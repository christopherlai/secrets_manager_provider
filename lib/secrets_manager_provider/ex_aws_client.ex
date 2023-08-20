defmodule SecretsManagerProvider.ExAwsClient do
  @moduledoc """
  Default Secrets Manager client used by `SecretsManagerProvider`.
  This client uses `ExAws.SecretsManager` library and implements the
  `SecretsManagerProvider.AwsClient` behaviour.
  """

  require Logger

  @behaviour SecretsManagerProvider.AwsClient

  @impl true
  def init(configuration) do
    {:ok, _deps} = Application.ensure_all_started(:ex_aws)

    configuration
  end

  @impl true
  def get_secrets(configuration) do
    configuration.name
    |> ExAws.SecretsManager.get_secret_value()
    |> ExAws.request(http_client: configuration.http_client)
    |> handle_response()
  end

  defp handle_response({:ok, %{"SecretString" => secret}}), do: secret

  defp handle_response({:error, reason}) do
    Logger.error("Unable to fetch secrets from AWS. Reason: #{inspect(reason)}")
  end
end
