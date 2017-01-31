# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :chat_phoenix,
  ecto_repos: [ChatPhoenix.Repo]

# Configures the endpoint
config :chat_phoenix, ChatPhoenix.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "s4YjHU7Ng/9OIXSmSeyMJQD6l+WgJ7DtyMR6GM6Tt4Nta6RVLzucbCXB4/grSYOJ",
  render_errors: [view: ChatPhoenix.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ChatPhoenix.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
