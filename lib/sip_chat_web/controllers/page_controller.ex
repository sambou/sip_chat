defmodule SipChatWeb.PageController do
  use SipChatWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
