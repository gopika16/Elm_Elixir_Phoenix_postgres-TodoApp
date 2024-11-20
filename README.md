# TodoApp

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
#   t o d o A p p 
 
 

APis:

get specific task/ GET TASK BY ID
iex(5)> task = TodoAppWeb.Contexts.TodoContext.get_task_by_id!(3)

get/READ todos 
http://localhost:4000/todos
TodoAppWeb.Contexts.TodoContext.list_todos()

add/CREATE task
iex(3)> TodoAppWeb.Contexts.TodoContext.create_task(%{description: "task3", is_complete: false}) 

UPDATE/edit task
iex(9)> TodoAppWeb.Contexts.TodoContext.update_task(task, %{is_complete: true})
UPDATE "tasks" SET "is_complete" = $1 WHERE "id" = $2 [true, 3]

DELETE/remove
iex(12)> TodoAppWeb.Contexts.TodoContext.delete_task(task)


doubt

 : () -> ( Model, Cmd Msg ) vs  :( Model, Cmd Msg )