defmodule SecretsManagerProvider do
  @moduledoc """
  AWS Secrets Manager ConfigProvider for Elixir Releases.
  """

  @behaviour Config.Provider

  import SecretsManagerProvider.Utils, only: [to_keyword: 1]
  alias SecretsManagerProvider.Configuration

  @impl true
  def init(args), do: args

  @impl true
  def load(config, args) do
    {:ok, _deps} = Application.ensure_all_started(:hackney)
    {:ok, _deps} = Application.ensure_all_started(:ex_aws)
    configuration = Configuration.new()

    args
    |> get_path()
    |> configuration.client.get_secrets()
    |> configuration.parser.decode!()
    |> to_keyword()
    |> merge_configs(config)
  end

  defp get_path({:env, name}), do: System.get_env(name)
  defp get_path({:path, path}), do: path

  defp merge_configs(secrets, config) do
    Config.Reader.merge(config, secrets)
  end
end
