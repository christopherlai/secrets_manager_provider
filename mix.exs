defmodule SecretsManagerProvider.MixProject do
  use Mix.Project

  def project do
    [
      app: :secrets_manager_provider,
      version: "0.2.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:configparser_ex, "~> 4.0", override: true, only: [:dev, :test]},
      {:ex_aws, "~> 2.1", override: true},
      {:ex_aws_ssm, "~> 2.0"},
      {:ex_doc, "~> 0.20.2"},
      {:hackney, "~> 1.15"},
      {:jason, "~> 1.1"},
      {:toml, "~> 0.5.2"}
    ]
  end
end
