defmodule SipChatWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_info(:after_join, socket) do
    push(socket, "presence_state", SipChatWeb.Presence.list(socket))

    {:ok, _} =
      SipChatWeb.Presence.track(socket, socket.assigns.user_id, %{
        online_at: inspect(System.system_time(:second))
      })

    {:noreply, socket}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast!(socket, "new_msg", %{body: "#{socket.assigns[:name]}: #{body}"})

    {:noreply, socket}
  end
end
