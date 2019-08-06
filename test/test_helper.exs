ExUnit.start()
ExUnit.configure(exclude: [:external])

Mox.defmock(SecretsManagerProvider.MockClient, for: SecretsManagerProvider.SecretsManagerClient)
