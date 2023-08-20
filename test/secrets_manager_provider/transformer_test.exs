defmodule SecretsManagerProvider.TransformerTest do
  use ExUnit.Case, async: true

  alias SecretsManagerProvider.Transformer

  describe "to_keyword/1" do
    test "returns keywords for a given map" do
      expected = [url: "http://url/to"]

      assert Transformer.to_keyword(%{"url" => "http://url/to"}) == expected
    end

    test "returns nested keywords for a given nested map" do
      expected = [database: [url: "http://url/to"]]

      assert Transformer.to_keyword(%{"database" => %{"url" => "http://url/to"}}) == expected
    end

    test "returns the passed value if it is not a list or map" do
      assert Transformer.to_keyword("http://database") == "http://database"
    end
  end

  describe "to_atom/1" do
    test "returns an string atom" do
      assert Transformer.to_atom("Some.Module") == :"Elixir.Some.Module"
    end

    test "returns an atom" do
      assert Transformer.to_atom("somemodule") == :somemodule
    end
  end
end
