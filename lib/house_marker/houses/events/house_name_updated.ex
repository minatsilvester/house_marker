defmodule HouseMarker.Houses.Events.HouseNameUpdated do
  @derive Jason.Encoder

  defstruct [
    :uuid,
    :name
  ]
end
