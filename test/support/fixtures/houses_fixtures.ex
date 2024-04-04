defmodule HouseMarker.HousesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HouseMarker.Houses` context.
  """

  @doc """
  Generate a house.
  """
  def house_fixture(attrs \\ %{}) do
    {:ok, house} =
      attrs
      |> Enum.into(%{

      })
      |> HouseMarker.Houses.create_house()

    house
  end
end
