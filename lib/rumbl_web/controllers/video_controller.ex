defmodule RumblWeb.VideoController do
  use RumblWeb, :controller

  alias Rumbl.Categories
  alias Rumbl.Categories.Video

  def index(conn, _params) do
    videos = Categories.list_videos()
    render(conn, "index.html", videos: videos)
  end

  def new(conn, _params) do
    current_user = conn.assigns.current_user
    changeset = Categories.change_video_for_user(current_user)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"video" => video_params}) do
    user = conn.assigns.current_user

    case Categories.create_video_for_user(video_params, user) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video created successfully.")
        |> redirect(to: video_path(conn, :show, video))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    video = Categories.get_video!(id)
    render(conn, "show.html", video: video)
  end

  def edit(conn, %{"id" => id}) do
    video = Categories.get_video!(id)
    changeset = Categories.change_video(video)
    render(conn, "edit.html", video: video, changeset: changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}) do
    video = Categories.get_video!(id)

    case Categories.update_video(video, video_params) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video updated successfully.")
        |> redirect(to: video_path(conn, :show, video))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", video: video, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = conn.assigns.current_user
    video = Categories.get_video!(id)
    {:ok, _video} = Categories.delete_video_for_user(video, user)

    conn
    |> put_flash(:info, "Video deleted successfully.")
    |> redirect(to: video_path(conn, :index))
  end
end
