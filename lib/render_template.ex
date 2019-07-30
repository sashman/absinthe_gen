defmodule AbsintheGen.RenderTemplate do
  @template_directory "templates"

  def render_types(context = %{web_module: _}, schema = %{alias: _, name: _, attrs: attrs})
      when is_map(attrs),
      do: render("types.eex", context: context, schema: schema)

  def render(template_name, bindings) do
    [@template_directory, template_name]
    |> Path.join()
    |> EEx.eval_file(bindings, trim: true)
  end
end
