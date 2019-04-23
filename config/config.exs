use Mix.Config

config :ex_aws,
  json_codec: Jason

import_config "#{Mix.env()}.exs"
