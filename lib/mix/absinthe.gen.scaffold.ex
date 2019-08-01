defmodule Mix.Tasks.Absinthe.Gen.Scaffold do
  use Mix.Task
  alias AbsintheGen.{RenderTemplate, OutputFiles}

  @shortdoc "Create absinthe scaffold files."
  def run([context | [name | attrs]]) do
    parent_app = AbsintheGen.parent_app()

    web_module =
      "#{
        parent_app
        |> Atom.to_string()
        |> Macro.camelize()
      }Web"

    ctx = %{web_module: web_module}

    schema = %{
      alias: context |> Macro.camelize() |> String.capitalize(),
      name: name,
      name_plural: "#{name}s",
      attrs: parse_attrs(attrs)
    }

    types_contents = RenderTemplate.render_types(ctx, schema)
    schema_contents = RenderTemplate.render_schema(ctx, schema)
    resolver_contents = RenderTemplate.render_resolver(ctx, schema)

    [
      {Path.join(["lib", "#{parent_app}_web", "schema", "#{context}_types.ex"]), types_contents},
      {Path.join(["lib", "#{parent_app}_web", "schema.ex"]), schema_contents},
      {Path.join(["lib", "#{parent_app}_web", "resolvers", "#{context}.ex"]), resolver_contents}
    ]
    |> OutputFiles.write_files()
    |> AbsintheGen.print_message()
  end

  defp parse_attrs(attrs) when is_list(attrs) do
    attrs
    |> Enum.reduce(%{}, fn attr_key_pair, acc ->
      [field, type] = String.split(attr_key_pair, ":")

      acc
      |> Map.put(field, type)
    end)
  end
end
