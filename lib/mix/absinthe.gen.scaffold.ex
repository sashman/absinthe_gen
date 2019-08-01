defmodule Mix.Tasks.Absinthe.Gen.Scaffold do
  use Mix.Task
  alias AbsintheGen.RenderTemplate

  @shortdoc "Create absinthe scaffold files."
  def run([context | [name | attrs]]) do
    parent_app = AbsintheGen.parent_app()

    web_module =
      "#{
        parent_app
        |> Atom.to_string()
        |> Macro.camelize()
      }Web"

    types_contents =
      RenderTemplate.render_types(%{web_module: web_module}, %{
        alias: context |> Macro.camelize() |> String.capitalize(),
        name: name,
        attrs: parse_attrs(attrs)
      })

    output = Path.join(["lib", "#{parent_app}_web", "schema", "#{context}_types.ex"])

    output
    |> Path.dirname()
    |> File.mkdir_p!()

    :ok =
      output
      |> File.write(types_contents)

    output
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
