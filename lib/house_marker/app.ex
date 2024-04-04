defmodule HouseMarker.App do
  use Commanded.Application,
    otp_app: :house_marker,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: HouseMarker.EventStore
    ]

  router(HouseMarker.Router)
end
