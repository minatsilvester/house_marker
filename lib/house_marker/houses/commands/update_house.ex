defmodule HouseMarker.Houses.Commands.UpdateHouse do
  defstruct [
    :uuid,
    :name,
    :address
  ]

  use ExConstructor

  alias HouseMarker.Houses.Commands.UpdateHouse

  def assign_uuid(%UpdateHouse{} = update_house, uuid) do
    %UpdateHouse{update_house | uuid: uuid}
  end
end
