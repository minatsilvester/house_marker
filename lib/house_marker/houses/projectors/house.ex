defmodule HouseMarker.Houses.Projectors.House do
  use Commanded.Projections.Ecto,
    name: "Houses.Projections.House",
    repo: HouseMarker.Repo,
    application: HouseMarker.App,
    consistency: :strong

  alias HouseMarker.Repo

  alias HouseMarker.Houses.Events.{HouseCreated, HouseNameUpdated, HouseAddressUpdated}

  alias HouseMarker.Houses.Projections.House

  project(%HouseCreated{} = created, _, fn multi ->
    Ecto.Multi.insert(multi, :house, House.changeset(%House{}, %{"uuid" => created.uuid, "name" => created.name, "address" => created.address}))
  end)

  project(%HouseNameUpdated{uuid: uuid} = updated, _, fn multi ->
    case Repo.get(House, uuid) do
      nil -> multi
      house -> Ecto.Multi.update(multi, :house, House.changeset(house, %{"name" => updated.name}))
    end
  end)

  project(%HouseAddressUpdated{uuid: uuid} = updated, _, fn multi ->
    case Repo.get(House, uuid) do
      nil -> multi
      house -> Ecto.Multi.update(multi, :house, House.changeset(house, %{"address" => updated.address}))
    end
  end)
end
