defmodule TodoApp.Repo.Migrations.AddTable do
  use Ecto.Migration

  def change do
    create table("tasks") do
      add :description, :string
      add :is_complete, :bool
    end
  end
end