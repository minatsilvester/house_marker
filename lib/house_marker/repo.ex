defmodule HouseMarker.Repo do
  use Ecto.Repo,
    otp_app: :house_marker,
    adapter: Ecto.Adapters.Postgres
end
