defmodule Jsonserve.Service do
  use Ecto.Model

  schema "services" do
    field :name
    field :json

    timestamps
  end
end
