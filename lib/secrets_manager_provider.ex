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
    configuration = Configuration.new(args)

    configuration
    |> Map.get(:name)
    |> configuration.client.get_secrets()
    |> configuration.parser.decode!()
    |> to_keyword()
    |> merge_configs(config)
  end

  defp merge_configs(secrets, config) do
    Config.Reader.merge(config, secrets)
  end
end
