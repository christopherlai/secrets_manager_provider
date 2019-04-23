defmodule SecretsManagerProvider.Transformation do
  def to_keyword(config) when is_map(config) do
    for {k, v} <- config do
      k = to_atom(k)
      {k, to_keyword(v)}
    end
  end

  def to_keyword([h | t]) when is_map(h) do
    [to_keyword(h) | to_keyword(t)]
  end

  def to_keyword([h | t]) do
    [to_atom(h) | to_keyword(t)]
  end

  def to_keyword([]), do: []

  def to_keyword(config), do: config

  def to_atom(<<k::utf8, _rest::binary>> = key) when k >= ?A and k <= ?Z do
    Module.concat([key])
  end

  def to_atom(key), do: String.to_atom(key)
end
