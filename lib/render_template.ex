defmodule AbsintheGen.RenderTemplate do
  @template_directory "templates"

  def render_types(context, schema),
    do: render("types.eex", context, schema)

  def render_schema(context, schema),
    do: render("schema.eex", context, schema)

  def render_resolver(context, schema),
    do: render("resolver.eex", context, schema)

  def render(
        template_name,
        %{web_module: _} = context,
        %{alias: _, name: _, attrs: attrs} = schema
      )
      when is_map(attrs) do
    file_dir =
      __ENV__.file
      |> Path.dirname()

    [file_dir, @template_directory, template_name]
    |> Path.join()
    |> EEx.eval_file([context: context, schema: schema], trim: true)
  end
end
