defmodule SecretsManagerProvider do
  use Mix.Releases.Config.Provider
  alias SecretsManagerProvider.{Configuration, Transformation, SecretsManager}

  def init([path]) do
    {:ok, _deps} = Application.ensure_all_started(:hackney)
    {:ok, _deps} = Application.ensure_all_started(:ex_aws)

    path
    |> SecretsManager.get()
    |> Toml.decode!()
    |> Transformation.to_keyword()
    |> Configuration.persist()
  end
end
