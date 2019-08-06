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
    |> ExAws.SSM.get_parameter(with_decryption: true)
    |> ExAws.request()
    |> handle_response()
  end

  defp handle_response({:ok, resp}) do
    get_in(resp, ["Parameter", "Value"])
  end

  defp handle_response({:error, reason}) do
    Logger.error("Unable to fetch secrests from AWS. Reason: #{inspect(reason)}")
  end
end
