defmodule HouseMarker.Houses.Events.HouseAddressUpdated do
  @derive Jason.Encoder

  defstruct [
    :uuid,
    :address
  ]
end
