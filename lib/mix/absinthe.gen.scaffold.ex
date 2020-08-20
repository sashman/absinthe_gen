defmodule Mix.Tasks.Absinthe.Gen.Scaffold do
  use Mix.Task
  alias AbsintheGen.{RenderTemplate, OutputFiles}

  @shortdoc "Create absinthe scaffold files."
  @moduledoc """
  Will generate a scaffold consisting of a schema, type and resolver files. Multiple fields are accepted.

  Example:
  ```
  mix absinthe.gen.scaffold my_context my_type my_field:string my_other_field:string [OPTIONS]

  Created:

    lib/absinthe_app_web/schema/my_context_types.ex
    lib/absinthe_app_web/schema.ex
    lib/absinthe_app_web/resolvers/my_type.ex
  ```

  Options:

  * `--path PATH` - specify a path where to create the generated files
  """
  def run(args) do
    parent_app = AbsintheGen.parent_app()

    {options, [context | [name | attrs]], _} = OptionParser.parse(args, switches: [path: :string])
    path = options[:path]

    create_files(path, parent_app, context, name, attrs)
  end

  defp create_files(path, parent_app, context, name, attrs) do
    ctx = %{web_module: web_module(parent_app)}

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
      {["lib", "#{parent_app}_web", path, "schema", "#{context}_types.ex"], types_contents},
      {["lib", "#{parent_app}_web", path, "schema.ex"], schema_contents},
      {["lib", "#{parent_app}_web", path, "resolvers", "#{context}.ex"], resolver_contents}
    ]
    |> Enum.map(fn {path_list, content} ->
      {path_list |> Enum.filter(& &1) |> Path.join(), content}
    end)
    |> OutputFiles.write_files()
    |> AbsintheGen.print_message()
  end

  defp web_module(parent_app),
    do:
      "#{
        parent_app
        |> Atom.to_string()
        |> Macro.camelize()
      }Web"

  defp parse_attrs(attrs) when is_list(attrs) do
    attrs
    |> Enum.map(fn attr_key_pair ->
      String.split(attr_key_pair, ":")
    end)
    |> Enum.filter(fn
      [_, _] -> true
      _ -> false
    end)
    |> Enum.into(%{}, fn [a, b] -> {a, b} end)
  end
end
