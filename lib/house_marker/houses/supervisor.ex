defmodule HouseMarker.Houses.Supervisor do
  use Supervisor

  alias HouseMarker.Houses

  def start_link(args) do
    Supervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(_args) do
    Supervisor.init(
      [
        Houses.Projectors.House
      ],
      strategy: :one_for_one
    )
  end
end
