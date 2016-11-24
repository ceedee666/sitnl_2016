defmodule SitBRU_Demo.PageController do
  use SitBRU_Demo.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
