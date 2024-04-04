defmodule HouseMarker.Houses.Commands.CreateHouse do
  defstruct [
    :uuid,
    :name,
    :address
  ]

  use ExConstructor

  alias HouseMarker.Houses.Commands.CreateHouse

  def assign_uuid(%CreateHouse{} = create_house, uuid) do
    %CreateHouse{create_house | uuid: uuid}
  end
end
