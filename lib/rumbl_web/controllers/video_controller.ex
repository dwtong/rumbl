defmodule RumblWeb.VideoController do
  use RumblWeb, :controller

  alias Rumbl.Categories
  alias Rumbl.Categories.Video

  plug :load_topics when action in [:new, :create, :edit, :update]

  def index(conn, _params) do
    # Move current user assignment to somewhere global?
    current_user = conn.assigns.current_user
    videos = Categories.list_videos_for_user(current_user)
    render(conn, "index.html", videos: videos)
  end

  def new(conn, _params) do
    current_user = conn.assigns.current_user
    changeset = Categories.new_video_for_user(current_user)
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
    current_user = conn.assigns.current_user
    video = Categories.get_video_for_user!(id, current_user)
    render(conn, "show.html", video: video)
  end

  def edit(conn, %{"id" => id}) do
    current_user = conn.assigns.current_user
    video = Categories.get_video_for_user!(id, current_user)
    changeset = Categories.change_video_for_user(video, current_user)
    render(conn, "edit.html", video: video, changeset: changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}) do
    current_user = conn.assigns.current_user
    video = Categories.get_video_for_user!(id, current_user)

    case Categories.update_video_for_user(video, video_params, current_user) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video updated successfully.")
        |> redirect(to: video_path(conn, :show, video))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", video: video, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    current_user = conn.assigns.current_user
    video = Categories.get_video_for_user!(id, current_user)
    {:ok, _video} = Categories.delete_video_for_user(video, current_user)

    conn
    |> put_flash(:info, "Video deleted successfully.")
    |> redirect(to: video_path(conn, :index))
  end

  def load_topics(conn, _) do
    topics = Categories.list_topics_by_name_and_id
    assign(conn, :topics, topics)
  end
end
