defmodule Rumbl.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rumbl.Accounts.User


  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :videos, Rumbl.Categories.Video

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :username])
    |> validate_required(:username)
    |> validate_length(:username, min: 1, max: 20)
  end

  def registration_changeset(%User{} = user, attrs) do
    user
    |> changeset(attrs)
    |> cast(attrs, ~w(password), [])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true,
    changes: %{password: password}} = changeset) do
      put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
  end
  defp put_pass_hash(changeset), do: changeset
end
