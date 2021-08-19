defmodule SecretsManagerProviderTest do
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!

  setup do
    {:ok, name: "/path/to"}
  end

  describe "init/1" do
    test "returns the given path", %{name: name} do
      assert SecretsManagerProvider.init([{:name, name}]) == [{:name, name}]
    end
  end

  describe "load/2 with TOML" do
    setup %{name: name} do
      args = [
        {:client, SecretsManagerProvider.MockClient},
        {:name, name},
        {:parser, Toml}
      ]

      SecretsManagerProvider.MockClient
      |> expect(:get_secrets, fn ^name ->
        """
        [toplevel]
        sublevel = "config"
        """
      end)

      expected = [toplevel: [sublevel: "config"]]

      {:ok, args: args, expected: expected}
    end

    test "returns keyword configurations", %{args: args, expected: expected} do
      assert SecretsManagerProvider.load([], args) == expected
    end

    test "returns merged keyword configurations", %{args: args, expected: expected} do
      assert SecretsManagerProvider.load([toplevel: [sublevel: false]], args) == expected
    end
  end

  describe "load/2 with JSON" do
    setup %{name: name} do
      args = [
        {:client, SecretsManagerProvider.MockClient},
        {:name, name},
        {:parser, Jason}
      ]

      SecretsManagerProvider.MockClient
      |> expect(:get_secrets, fn ^name ->
        """
        {"toplevel": {
          "sublevel": "config"
          }
        }
        """
      end)

      expected = [toplevel: [sublevel: "config"]]

      {:ok, args: args, expected: expected}
    end

    test "returns keyword configurations", %{args: args, expected: expected} do
      assert SecretsManagerProvider.load([], args) == expected
    end

    test "returns merged keyword configurations", %{args: args, expected: expected} do
      assert SecretsManagerProvider.load([toplevel: [sublevel: false]], args) == expected
    end
  end
end
