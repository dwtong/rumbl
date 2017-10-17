defmodule RumblWeb.SessionController do
  use RumblWeb, :controller
  alias Rumbl.Accounts

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"username" => username, "password" => password}}) do
    case RumblWeb.Auth.login_by_username_and_pass(conn, username, password, repo: Accounts) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid username/password combination.")
        |> render("new.html")
    end
  end

  def delete do
  end
end
