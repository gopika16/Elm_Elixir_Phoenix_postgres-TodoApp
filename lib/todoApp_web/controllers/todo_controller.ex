defmodule TodoAppWeb.TodoController do
  use TodoAppWeb, :controller
  alias TodoAppWeb.Contexts.TodoContext

  def get_todos(conn, _params) do
    # IO.inspect(params, label: "PARAMS")
    todos = TodoContext.list_todos()
    # json(conn, {:ok, todos})
    json(conn, %{status: "ok", todos: todos})
  end

  # def delete_task(conn, params) do
  def delete_task(conn, %{"id" => id}) do
    # IO.inspect(params, label: "PARAMS")
    case TodoContext.delete_task(id) do
      {:ok, _task} ->
        json(conn, %{status: "ok"})

      {:error, _reason} ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Task not found"})
    end
  end


  def edit_task(conn, params) do
    IO.inspect(params, label: "PARAMS")
    case TodoContext.update_task(params) do
      {:ok, _task} ->
        json(conn, %{status: "ok"})

      {:error, _reason} ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Task not found"})
    end
  end

  def create_task(conn, params) do
    IO.inspect(params, label: "PARAMS")
    case TodoContext.create_task(params) do
      {:ok, _task} ->
        json(conn, %{status: "ok"})

      {:error, _reason} ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Task not created"})
    end
  end
end
