defmodule Moodbox.Repo do
  use Ecto.Repo,
    otp_app: :moodbox,
    adapter: Ecto.Adapters.Postgres
end
