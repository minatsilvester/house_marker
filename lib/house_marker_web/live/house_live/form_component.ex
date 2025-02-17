defmodule HouseMarkerWeb.HouseLive.FormComponent do
  use HouseMarkerWeb, :live_component

  alias HouseMarker.Houses

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage house records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="blog-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:address]} type="text" label="Address" />
        <:actions>
          <.button phx-disable-with="Saving...">Save House</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{house: house} = assigns, socket) do
    changeset = Houses.change_house(house)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"house" => house_params}, socket) do
    changeset =
      socket.assigns.house
      |> Houses.change_house(house_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end


  def handle_event("save", %{"house" => house_params}, socket) do
    save_house(socket, socket.assigns.action, house_params)
  end

  defp save_house(socket, :edit, house_params) do
    case Houses.update_house(socket.assigns.house, house_params) do
      {:ok, house} ->
        notify_parent({:saved, house})

        {:noreply,
         socket
         |> put_flash(:info, "Blog updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_house(socket, :new, house_params) do
    case Houses.create_house(house_params) do
      {:ok, house} ->
        notify_parent({:saved, house})

        {:noreply,
         socket
         |> put_flash(:info, "Blog created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
