use Mix.Config

config :ex_aws,
  access_key_id: [:instance_role],
  secret_access_key: [:instance_role]
