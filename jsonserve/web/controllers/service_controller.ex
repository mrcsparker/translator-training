defmodule Jsonserve.ServiceController do
  use Jsonserve.Web, :controller
  alias Jsonserve.Repo
  alias Jsonserve.Service

  plug :action

  def index(conn, _params) do
    services = Repo.all(Service)
    render conn, services: services
  end
end
