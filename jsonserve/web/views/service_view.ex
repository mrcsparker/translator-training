defmodule Jsonserve.ServiceView do
  use Jsonserve.Web, :view

  def render("index.json", %{services: services}) do
    services
  end
end
