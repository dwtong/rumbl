defmodule Rumbl.Repo.Migrations.AddPasswordHashToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :password
      remove :email
      add :password_hash, :string
      add :username, :string, null: false
    end

    create unique_index(:users, [:username])
  end
end
