defmodule TodoAppWeb.Todos do
  # use TodoAppWeb, :model
  use Ecto.Schema
	import Ecto.Changeset


  @derive {Jason.Encoder, only: [:id, :description, :is_complete]}

  schema "tasks" do
    field :description, :string
    field :is_complete, :boolean
  end

  def changeset(topic, params \\ %{}) do
    IO.inspect(topic, label: "changeset topic")
    IO.inspect(params, label: "changeset params")

    topic
    |> cast(params, [:description, :is_complete])
    |> validate_required([:description])
  end
end
