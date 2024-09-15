defmodule LivePomodoro.Repo do
  use Ecto.Repo,
    otp_app: :live_pomodoro,
    adapter: Ecto.Adapters.Postgres
end
