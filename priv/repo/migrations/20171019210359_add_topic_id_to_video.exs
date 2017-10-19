defmodule Rumbl.Repo.Migrations.AddTopicIdToVideo do
  use Ecto.Migration

  def change do
    alter table(:videos) do
      add :topic_id, references(:topics, on_delete: :nothing)
    end

    create index(:videos, [:topic_id])
  end
end
