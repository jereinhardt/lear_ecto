use Mix.Config

config :lear_ecto,
  repo: LearEcto.TestRepo,
  ecto_repos: [LearEcto.TestRepo]
  
config :lear_ecto, LearEcto.TestRepo,
  adapter: Ecto.Adapters.Postgres,
  database: "lear_ecto_test_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox