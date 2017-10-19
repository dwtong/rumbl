defmodule Rumbl.Categories.Video do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rumbl.Categories.Video


  schema "videos" do
    field :description, :string
    field :title, :string
    field :url, :string
    timestamps()

    belongs_to :user, Rumbl.Accounts.User
    belongs_to :topic, Rumbl.Categories.Topic
  end

  @doc false
  def changeset(%Video{} = video, attrs) do
    video
    |> cast(attrs, [:url, :title, :description])
    |> validate_required([:url, :title, :description])
    |> assoc_constraint(:topic)
  end
end
