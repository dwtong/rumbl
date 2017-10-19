defmodule Rumbl.Categories.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rumbl.Categories.Topic


  schema "topics" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Topic{} = topic, attrs) do
    topic
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
