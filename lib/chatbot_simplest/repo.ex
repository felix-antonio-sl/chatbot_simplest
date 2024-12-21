defmodule ChatbotSimplest.Repo do
  use Ecto.Repo,
    otp_app: :chatbot_simplest,
    adapter: Ecto.Adapters.Postgres
end
