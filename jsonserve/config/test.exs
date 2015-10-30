use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :jsonserve, Jsonserve.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :jsonserve, Jsonserve.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "",
  database: "movies_test",
  pool: Ecto.Adapters.SQL.Sandbox
