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

  alias Rumbl.Categories.Topic

  @doc """
  Returns the list of topics.

  ## Examples

      iex> list_topics()
      [%Topic{}, ...]

  """
  def list_topics do
    Repo.all(Topic)
  end

  @doc """
  Gets a single topic.

  Raises `Ecto.NoResultsError` if the Topic does not exist.

  ## Examples

      iex> get_topic!(123)
      %Topic{}

      iex> get_topic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_topic!(id), do: Repo.get!(Topic, id)

  @doc """
  Creates a topic.

  ## Examples

      iex> create_topic(%{field: value})
      {:ok, %Topic{}}

      iex> create_topic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_topic(attrs \\ %{}) do
    %Topic{}
    |> Topic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a topic.

  ## Examples

      iex> update_topic(topic, %{field: new_value})
      {:ok, %Topic{}}

      iex> update_topic(topic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_topic(%Topic{} = topic, attrs) do
    topic
    |> Topic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Topic.

  ## Examples

      iex> delete_topic(topic)
      {:ok, %Topic{}}

      iex> delete_topic(topic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_topic(%Topic{} = topic) do
    Repo.delete(topic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking topic changes.

  ## Examples

      iex> change_topic(topic)
      %Ecto.Changeset{source: %Topic{}}

  """
  def change_topic(%Topic{} = topic) do
    Topic.changeset(topic, %{})
  end
end
