defmodule Mix.Tasks.Absinthe.Gen.Scaffold do
  use Mix.Task
  alias AbsintheGen.RenderTemplate

  @shortdoc "Create absinthe scaffold files."
  def run([context | [name | attrs]]) do
    web_module = "#{AbsintheGen.parent_app()}Web"

    types_contents =
      RenderTemplate.render_types(%{web_module: web_module}, %{
        alias: context,
        name: name,
        attrs: parse_attrs(attrs)
      })

    File.write("#{context}_types.ex", types_contents)
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
