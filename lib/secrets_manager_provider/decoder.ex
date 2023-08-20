defmodule SecretsManagerProvider.Decoder do
  @moduledoc """
  Behaviour for decoding secret values into Elixir/Erlang terms.
  """

  @callback decode!(iodata()) :: term() | no_return()

  def decode!(data, configuration) do
    configuration.decoder.decode!(data)
  end
end
