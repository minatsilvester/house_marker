defmodule HouseMarker.Repo.Migrations.CreateHouses do
  use Ecto.Migration

  def change do
    create table(:houses, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :name, :string
      add :address, :text
      add :pincode, :string
      timestamps(type: :utc_datetime)
    end
  end
end
