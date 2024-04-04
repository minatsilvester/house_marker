defmodule HouseMarker.Houses.Events.HouseCreated do
  @derive Jason.Encoder

  defstruct [
    :uuid,
    :name,
    :address
  ]
end
