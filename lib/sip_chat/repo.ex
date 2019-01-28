defmodule SipChat.Repo do
  use Ecto.Repo,
    otp_app: :sip_chat,
    adapter: Ecto.Adapters.Postgres
end
