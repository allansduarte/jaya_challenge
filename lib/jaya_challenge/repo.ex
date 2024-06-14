defmodule JayaChallenge.Repo do
  use Ecto.Repo,
    otp_app: :jaya_challenge,
    adapter: Ecto.Adapters.Postgres
end
