# House Marker

The project maintaints a list of houses/aprtments and then points them in the map using the address given

## Steps to Run

- mix deps.get
- mix ecto.create
- mix ecto.migrate
- mix do event_store.create, event_store.init
- iex -S mix phx.server
- visit localhost:4000/houses

## References and Libraries Used
- Article - https://dev.to/christianalexander/using-cqrs-in-a-simple-phoenix-api-with-commanded-364k
- Commanded Elixir - https://github.com/commanded/commanded
- Commanded EventStore - https://github.com/commanded/eventstore
- Commanded ecto projections - https://github.com/commanded/commanded-ecto-projections
