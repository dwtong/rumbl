defmodule RumblWeb.Router do
  use RumblWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug RumblWeb.Auth, repo: Rumbl.Accounts
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RumblWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/manage", RumblWeb do
    pipe_through [:browser, :authenticate_user]

    resources "/videos", VideoController
  end
end
