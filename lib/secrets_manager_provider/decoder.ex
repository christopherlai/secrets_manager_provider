defmodule SecretsManagerProvider.Decoder do
 @callback decode!(iodata()) :: term() | no_return()

 def decode!(data, configuration) do
    configuration.parser.decode!(data)
  end
end
