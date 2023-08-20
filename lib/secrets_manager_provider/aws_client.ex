defmodule SecretsManagerProvider.AwsClient do
  @moduledoc """
  A generic behaviour to implement Secret Manager Client for `SecretsManagerProvider`.
  """

  alias SecretsManagerProvider.Configuration

  @callback init(configuration :: Configuration.t()) :: Configuration.t()

  @callback get_secrets(configuration :: Configuration.t()) :: binary()

  def init(configuration), do: configuration.aws_client.init(configuration)

  def get_secrets(configuration), do: configuration.aws_client.get_secrets(configuration)
end
