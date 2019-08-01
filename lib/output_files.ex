defmodule AbsintheGen.OutputFiles do
  def write_files(files) when is_list(files) do
    files
    |> Enum.map(fn {output, content} ->
      output
      |> Path.dirname()
      |> File.mkdir_p!()

      :ok =
        output
        |> File.write(content)

      output
    end)
  end
end
