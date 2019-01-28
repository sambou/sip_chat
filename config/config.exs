# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sip_chat,
  ecto_repos: [SipChat.Repo]

# Configures the endpoint
config :sip_chat, SipChatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XAh2USdTKEgZeHqBzdNW6V6WWScHIcYjG9xM9MMy+/FyNG55LFNGsSoZq3D9Q6Se",
  render_errors: [view: SipChatWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SipChat.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
