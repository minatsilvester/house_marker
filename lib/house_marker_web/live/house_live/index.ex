defmodule HouseMarkerWeb.HouseLive.Index do
  use HouseMarkerWeb, :live_view

  alias HouseMarker.Houses
  alias HouseMarker.Houses.Projections.House


  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> stream_configure(:houses, dom_id: &("#{&1.uuid}")) |> stream(:houses, Houses.list_houses())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event("show_on_map", args, socket) do
    house = Houses.get_house!(args["id"])
    {:noreply, assign(socket, :active_on_map, construct_map_url(house))}
  end

  defp apply_action(socket, :index, _params) do
    houses = Houses.list_houses()
    house =
      if Enum.empty?(houses) do
        nil
      else
        [head | _] = Houses.list_houses()
        head
      end
    socket
    |> assign(:page_title, "Listing Houses")
    |> assign(:active_on_map, construct_map_url(house))
  end

  defp apply_action(socket, :edit, %{"id" => uuid}) do
    socket
    |> assign(:page_title, "Edit House")
    |> assign(:house, Houses.get_house!(uuid))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New House")
    |> assign(:house, %House{})
  end

  @impl true
  def handle_info({HouseMarkerWeb.HouseLive.FormComponent, {:saved, house}}, socket) do
    {:noreply, stream_insert(socket, :houses, house)}
  end

  defp construct_map_url(nil) do
    nil
  end

  defp construct_map_url(house) do
    "https://www.google.com/maps/embed/v1/place?key=AIzaSyBZ2cpYJyOqOEi_lWJDEDZoYbzs3PljEUE&q=#{house.address}"
  end

end
