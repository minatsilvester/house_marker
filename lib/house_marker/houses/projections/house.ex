defmodule HouseMarker.Houses.Projections.House do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, :binary_id, autogenerate: false}
  @derive {Phoenix.Param, key: :uuid}

  schema "houses" do

    field :name, :string
    field :address, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(house, attrs) do
    house
    |> cast(attrs, [:uuid, :name, :address])
    |> validate_required([:uuid, :name, :address])
  end
end
