defmodule SecretsManagerProvider.ConfigurationTest do
  use ExUnit.Case, async: true

  alias SecretsManagerProvider.Configuration

  describe "new/1" do
    test "returns Configuration struct with default values" do
      config = Configuration.new([{:name, "secret/name"}])

      assert config == %Configuration{
               client: SecretsManagerProvider.ExAwsClient,
               name: "secret/name",
               parser: Toml
             }
    end

    test ~s("when config field is given in the `{:system, "ENV_NAME"}` format, get environment value) do
      System.put_env("SECRET_NAME", "secret/name")
      config = Configuration.new([{:name, {:system, "SECRET_NAME"}}])

      assert config == %Configuration{
               client: SecretsManagerProvider.ExAwsClient,
               name: "secret/name",
               parser: Toml
             }
    end
  end
end
