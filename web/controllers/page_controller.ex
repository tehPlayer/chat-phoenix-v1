defmodule ChatPhoenix.PageController do
  use ChatPhoenix.Web, :controller
  alias ChatPhoenix.Repo
  alias ChatPhoenix.Message

  def index(conn, _params) do
    messages = Repo.all(Message)
    render conn, "index.html", messages: messages
  end
end
