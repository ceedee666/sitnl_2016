ExUnit.start

Mix.Task.run "ecto.create", ~w(-r SitBRU_Demo.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r SitBRU_Demo.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(SitBRU_Demo.Repo)

