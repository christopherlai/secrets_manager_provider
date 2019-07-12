defmodule SecretsManagerProvider do
  @behaviour Config.Provider

  alias SecretsManagerProvider.{Transformation, SecretsManager}

  def init(path) when is_binary(path), do: path

  def load(config, path) do
    {:ok, _deps} = Application.ensure_all_started(:hackney)
    {:ok, _deps} = Application.ensure_all_started(:ex_aws)

    secrets =
      path
      |> SecretsManager.get()
      |> Toml.decode!()
      |> Transformation.to_keyword()

    Config.Reader.merge(config, secrets)
  end
end
