defmodule Jsonserve.ServiceControllerTest do
  use ExUnit.Case, async: false
  use Plug.Test
  alias Jsonserve.Service
  alias Jsonserve.Repo
  alias Ecto.Adapters.SQL

  setup do
    SQL.begin_test_transaction(Repo)

    on_exit fn ->
      SQL.rollback_test_transaction(Repo)
    end
  end

  test "/index returns a list of services" do
    services_as_json =
      %Service{name: "mrcsparker", json: "{\"name\": \"Chris Parker\"}"}
      |> Repo.insert
      |> List.wrap
      |> Poison.encode!

    response = conn(:get, "/api/services") |> send_request

    assert response.status == 200
    assert response.body == services_as_json
  end

  defp send_request(conn) do
    conn
    |> put_private(:plug_skip_csrf_protection, true)
    |> Jsonserve.Endpoint.call([])
  end
end
