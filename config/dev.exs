use Mix.Config

config :ex_aws,
  access_key_id: [{:awscli, "default", 30}],
  secret_access_key: [{:awscli, "default", 30}],
  region: "us-east-1"
