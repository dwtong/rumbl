defmodule Rumbl.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rumbl.Accounts.User


  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :username, :password])
    |> validate_required([:name, :username, :password])
  end
end
