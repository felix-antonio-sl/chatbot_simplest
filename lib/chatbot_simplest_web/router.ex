defmodule ChatbotSimplestWeb.Router do
  use ChatbotSimplestWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ChatbotSimplestWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", ChatbotSimplestWeb do
    pipe_through :browser

    live "/", ChatLive, :index  # <-- Aquí nuestro LiveView
  end
end
