defmodule SecretsManagerProviderTest do
  use ExUnit.Case
  doctest SecretsManagerProvider

  test "greets the world" do
    assert SecretsManagerProvider.hello() == :world
  end
end
