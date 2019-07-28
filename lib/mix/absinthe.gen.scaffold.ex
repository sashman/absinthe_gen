defmodule Mix.Tasks.Absinthe.Gen.Scaffold do
  use Mix.Task
  alias AbsintheGen.RenderTemplate

  @shortdoc "Create absinthe scaffold files."
  def run(args) do
    IO.inspect(args)
    [context, name, _attrs] = args
    web_module = "#{AbsintheGen.parent_app()}Web"

    RenderTemplate.render_types(%{web_module: web_module}, %{
      alias: context,
      name: name,
      attrs: %{}
    })
    |> IO.inspect()
  end
end
