defmodule SecretsManagerProvider do
  @moduledoc """
  AWS Secrets Manager ConfigProvider for Elixir Releases.  
  """

  @behaviour Config.Provider

  import SecretsManagerProvider.Utils, only: [to_keyword: 1]
  alias SecretsManagerProvider.ExAwsClient

  @impl true
  def init(path) when is_binary(path), do: path

  @impl true
  def load(config, path) do
    {:ok, _deps} = Application.ensure_all_started(:hackney)
    {:ok, _deps} = Application.ensure_all_started(:ex_aws)

    client = Application.get_env(:secrets_manager_provider, :client, ExAwsClient)
    parser = Application.get_env(:secrets_manager_provider, :parser, Toml)

    secrets =
      path
      |> client.get_secrets()
      |> parser.decode!()
      |> to_keyword()

    Config.Reader.merge(config, secrets)
  end
end
