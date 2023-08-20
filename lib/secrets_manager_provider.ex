defmodule SecretsManagerProvider do
  @moduledoc """
  AWS Secrets Manager ConfigProvider for Elixir Releases.
  """

  @behaviour Config.Provider

  alias SecretsManagerProvider.Transformer
  alias SecretsManagerProvider.Configuration
  alias SecretsManagerProvider.AwsClient
  alias SecretsManagerProvider.HttpClient
  alias SecretsManagerProvider.Decoder

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
      |> Decoder.decode!(configuration)
      |> Transformer.to_keyword()

    Config.Reader.merge(config, secret_config)
  end
end
