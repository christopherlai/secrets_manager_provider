defmodule SecretsManagerProvider do
  use Mix.Releases.Config.Provider
  alias SecretsManagerProvider.{Configuration, Transformation, SecretsManager}

  def init([path]) do
    path
    |> SecretsManager.get()
    |> Toml.decode!()
    |> Transformation.to_keyword()
    |> Configuration.persist()
  end
end
