defmodule Rumbl.Categories do
  @moduledoc """
  The Categories context.
  """

  import Ecto.Query, warn: false
  alias Rumbl.Repo

  alias Rumbl.Categories.Video

  def list_videos_for_user(user) do
    user
    |> user_videos()
    |> Repo.all
  end

  def get_video_for_user!(id, user) do
    user
    |> user_videos()
    |> Repo.get!(id)
  end

  def create_video_for_user(attrs \\ %{}, user) do
    user
    |> Ecto.build_assoc(:videos)
    |> Video.changeset(attrs)
    |> Repo.insert()
  end

  def update_video_for_user(%Video{} = video, attrs, user) do
    video
    |> Video.changeset(attrs)
    |> Repo.update()
  end

  def delete_video_for_user(%Video{} = video, user) do
    user
    |> user_videos()
    |> Repo.get(video.id)
    |> Repo.delete()
  end

  def change_video_for_user(%Video{} = video, user) do
    user
    |> user_videos()
    |> Repo.get(video.id)
    |> Video.changeset(%{})
  end

  def new_video_for_user(user) do
    user
    |> Ecto.build_assoc(:videos)
    |> Video.changeset(%{})
  end

  defp user_videos(user) do
    Ecto.assoc(user, :videos)
  end
end
