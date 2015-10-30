defmodule Jsonserve.Repo.Migrations.CreateServices do
  use Ecto.Migration

  def change do
    create table(:services) do
      add :name, :string
      add :json, :text

      timestamps
    end
  end
end
