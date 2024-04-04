defmodule HouseMarker.Router do
  use Commanded.Commands.Router

  alias HouseMarker.Houses.Aggregates.House

  alias HouseMarker.Houses.Commands.{CreateHouse, UpdateHouse}

  dispatch([CreateHouse], to: House, identity: :uuid)
  dispatch([UpdateHouse], to: House, identity: :uuid)
end
