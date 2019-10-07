defmodule SecretsManagerProviderKeywordsTest do
  use ExUnit.Case, async: false

  import Mox

  setup :verify_on_exit!

  describe "init/1" do
    test "returns a given keywords" do
      assert SecretsManagerProvider.init(env_var: "SOME_VAR") == [env_var: "SOME_VAR"]
    end
  end

  describe "load/2 with TOML using env var" do
    setup do
      System.put_env("SOME_VAR", "aws/secret/keystore")
      Application.put_env(:secrets_manager_provider, :client, SecretsManagerProvider.MockClient)
      Application.put_env(:secrets_manager_provider, :parser, Toml)

      SecretsManagerProvider.MockClient
      |> expect(:get_secrets, fn _path ->
        """
        [toplevel]
        sublevel = "config"
        """
      end)

      expected = [toplevel: [sublevel: "config"]]

      {:ok, %{expected: expected}}
    end

    test "returns keyword configurations from env var", %{expected: expected} do
      assert SecretsManagerProvider.load([], env_var: "SOME_VAR") == expected
    end

    test "returns merged keyword configurations", %{expected: expected} do
      assert SecretsManagerProvider.load([toplevel: [sublevel: false]], env_var: "SOME_VAR") ==
               expected
    end
  end

  describe "load/2 with TOML using path keyword" do
    setup do
      Application.put_env(:secrets_manager_provider, :client, SecretsManagerProvider.MockClient)
      Application.put_env(:secrets_manager_provider, :parser, Toml)

      SecretsManagerProvider.MockClient
      |> expect(:get_secrets, fn _path ->
        """
        [toplevel]
        sublevel = "config"
        """
      end)

      expected = [toplevel: [sublevel: "config"]]

      {:ok, %{expected: expected}}
    end

    test "returns keyword configurations from env var", %{expected: expected} do
      assert SecretsManagerProvider.load([], path: "/some/path") == expected
    end

    test "returns merged keyword configurations", %{expected: expected} do
      assert SecretsManagerProvider.load([toplevel: [sublevel: false]], path: "/some/path") ==
               expected
    end
  end
end
