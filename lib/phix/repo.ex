defmodule Phix.Repo do
  use Ecto.Repo,
    otp_app: :phix,
    adapter: Ecto.Adapters.Postgres
end
