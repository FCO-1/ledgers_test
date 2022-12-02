defmodule LedgersBucketsWeb.PageController do
  use LedgersBucketsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
