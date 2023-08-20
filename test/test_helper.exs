ExUnit.start()
ExUnit.configure(exclude: [:external])

Mox.defmock(SecretsManagerProvider.MockAwsClient, for: SecretsManagerProvider.AwsClient)
