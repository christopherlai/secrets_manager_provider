defmodule SecretsManagerProvider do
  @moduledoc """
  AWS Secrets Manager ConfigProvider for Elixir Releases.
  """

  @behaviour Config.Provider

  import SecretsManagerProvider.Utils, only: [to_keyword: 1]
  alias SecretsManagerProvider.Configuration

  @impl true
  def init(args) do
    configuration = Configuration.new(args)

    configuration
    |> configuration.http_client.init()
    |> configuration.client.init()
  end

  @impl true
  def load(config, configuration) do
    secret_config =
      configuration.name
      |> configuration.client.get_secrets(configuration)
      |> configuration.parser.decode!()
      |> to_keyword()

    Config.Reader.merge(config, secret_config)
  end
end
