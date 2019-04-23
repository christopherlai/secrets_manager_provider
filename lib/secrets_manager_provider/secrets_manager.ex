defmodule SecretsManagerProvider.SecretsManager do
  def get(path) do
    path
    |> ExAws.SSM.get_parameter(with_decryption: true)
    |> ExAws.request()
    |> case do
      {:ok, response} -> get_in(response, ["Parameter", "Value"])
      _ -> ""
    end
  end
end
