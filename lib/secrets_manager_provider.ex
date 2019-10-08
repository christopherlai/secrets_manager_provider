defmodule SecretsManagerProvider do
  @moduledoc """
  AWS Secrets Manager ConfigProvider for Elixir Releases.
  """

  @behaviour Config.Provider

  import SecretsManagerProvider.Utils, only: [to_keyword: 1]
  alias SecretsManagerProvider.ExAwsClient

  @impl true
  def init(args), do: args

  @impl true
  def load(config, args) do
    {:ok, _deps} = Application.ensure_all_started(:hackney)
    {:ok, _deps} = Application.ensure_all_started(:ex_aws)

    client = Application.get_env(:secrets_manager_provider, :client, ExAwsClient)
    parser = Application.get_env(:secrets_manager_provider, :parser, Toml)

    secrets = extract_secrets(client, parser, args)

    Config.Reader.merge(config, secrets)
  end

  defp extract_secrets(client, parser, path) when is_binary(path) do
    extract_secrets_from_path(client, parser, path)
  end

  defp extract_secrets(client, parser, {:env, var_name}) do
    path = System.get_env(var_name)
    extract_secrets_from_path(client, parser, path)
  end

  defp extract_secrets(client, parser, {:path, path}) do
    extract_secrets_from_path(client, parser, path)
  end

  defp extract_secrets_from_path(client, parser, path) when is_binary(path) do
    path
    |> client.get_secrets()
    |> parser.decode!()
    |> to_keyword()
  end
end
