defmodule ChatPhoenix.RoomChannel do
  alias ChatPhoenix.Repo
  alias ChatPhoenix.Message

  use ChatPhoenix.Web, :channel

  def join("room:lobby", payload, socket) do
    if authorized?(payload) do
      send(self(), {:after_join, payload})
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info({:after_join, msg}, socket) do
    broadcast! socket, "user:entered", %{user: msg["user"]}
    push socket, "join", %{status: "connected"}
    {:noreply, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  def handle_in("new:msg", payload, socket) do
    user = if (payload["user"] == ""), do: "anonymous", else: payload["user"]
    changeset = Message.changeset(%Message{}, %{author: user, body: payload["body"]})
    if changeset.valid? do
      Repo.insert(changeset)
      broadcast(socket, "new:msg", payload)
    end
    {:noreply, socket}
  end

  def handle_in("user:entered", payload, socket) do
    broadcast socket, "user:entered", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
