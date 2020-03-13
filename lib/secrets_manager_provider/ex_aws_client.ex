defmodule SecretsManagerProvider.ExAwsClient do
  @moduledoc """
  Default Secrets Manager client used by `SecretsManagerProvider`.
  This client uses `ExAws.SecretsManager` library and implements the
  `SecretsManagerProvider.SecretsManagerClient` behaviour.
  """

  require Logger

  @behaviour SecretsManagerProvider.SecretsManagerClient

  @impl true
  def get_secrets(path) do
    path
    |> ExAws.SecretsManager.get_secret_value()
    |> ExAws.request()
    |> handle_response()
  end

  defp handle_response({:ok, %{"SecretString" => secret}}), do: secret

  defp handle_response({:error, reason}) do
    Logger.error("Unable to fetch secrets from AWS. Reason: #{inspect(reason)}")
  end
end
