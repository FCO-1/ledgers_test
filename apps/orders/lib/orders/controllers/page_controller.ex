defmodule Orders.PageController do
  use Orders, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
