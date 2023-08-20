defmodule SecretsManagerProvider.Transformer do
  @moduledoc """
  Utilities for converting Maps to Keywords and atomizing keys.
  """

  def to_keyword(config) when is_map(config) do
    for {k, v} <- config do
      k = to_atom(k)
      {k, to_keyword(v)}
    end
  end

  def to_keyword(config), do: config

  def to_atom(<<k::utf8, _rest::binary>> = key) when k >= ?A and k <= ?Z do
    Module.concat([key])
  end

  def to_atom(key), do: String.to_atom(key)
end
