defmodule TodoAppWeb.Contexts.TodoContext do
    alias TodoApp.Repo
    alias TodoAppWeb.Todos

    def get_task_by_id!(id), do: Repo.get!(Todos, id)

    def list_todos() do
      Repo.all(Todos)
    end

    def create_task(task \\ %{}) do
      %Todos{}
      |> Todos.changeset(task)
      |> Repo.insert()
    end

    def update_task(%{"description" => description, "id" => id, "isComplete" => is_complete}) do
      task = get_task_by_id!(id)
      todo = %{
        description: description,
        is_complete: is_complete
      }

      IO.inspect(todo, label: "TODO")
      task
      |> Todos.changeset(todo)
      |> Repo.update()
    end

    # def update_task(%Todos{} = task, todo) do

    #   task
    #   |> Todos.changeset(todo)
    #   |> Repo.update()
    # end

   def delete_task(id) do
    task = get_task_by_id!(id)
    Repo.delete(task)
  end
end
