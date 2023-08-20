defmodule SecretsManagerProvider do
  @moduledoc """
  AWS Secrets Manager ConfigProvider for Elixir Releases.
  """

  @behaviour Config.Provider

  import SecretsManagerProvider.Utils, only: [to_keyword: 1]
  alias SecretsManagerProvider.Configuration
  alias SecretsManagerProvider.AwsClient
  alias SecretsManagerProvider.HttpClient

  @impl true
  def init(args) do
    args
    |> Configuration.new()
    |> HttpClient.init()
    |> AwsClient.init()
  end

  @impl true
  def load(config, configuration) do
    secret_config =
      configuration
      |> AwsClient.get_secrets()
      |> configuration.parser.decode!()
      |> to_keyword()

    Config.Reader.merge(config, secret_config)
  end
end
