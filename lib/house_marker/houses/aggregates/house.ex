defmodule HouseMarker.Houses.Aggregates.House do

  defstruct [
    :uuid,
    :name,
    :address
  ]

  alias HouseMarker.Houses.Aggregates.House
  alias HouseMarker.Houses.Commands.{CreateHouse, UpdateHouse}
  alias HouseMarker.Houses.Events.{HouseCreated, HouseNameUpdated, HouseAddressUpdated}

  def execute(%House{}, %CreateHouse{} = create) do
    cond do
      !is_nil(create.name) && !is_nil(create.address) ->
        %HouseCreated{
          uuid: create.uuid,
          name: create.name,
          address: create.address
        }
      true ->
        {:error, "Name or address is nil"}
    end
  end

  def execute(%House{} = house, %UpdateHouse{} = updated) do
    name_command =
      if house.name != updated.name and not is_nil(updated.name),
        do: %HouseNameUpdated{uuid: house.uuid, name: updated.name}

    address_command =
      if house.address != updated.address and not is_nil(updated.address),
        do: %HouseAddressUpdated{uuid: house.uuid, address: updated.address}

    [name_command, address_command] |> Enum.filter(&Function.identity/1)
  end

  def apply(%House{} = house, %HouseCreated{} = created) do
    %House{
      house
      | uuid: created.uuid,
        name: created.name,
        address: created.address,
    }
  end

  def apply(%House{} = house, %HouseNameUpdated{name: name}) do
    %House{
      house
      | name: name
    }
  end

  def apply(%House{} = house, %HouseAddressUpdated{address: address}) do
    %House{
      house
      | address: address
    }
  end
end
