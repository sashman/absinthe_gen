defmodule AbsintheGen do
  @moduledoc """
  Documentation for AbsintheGen.
  """

  def parent_app do
    Mix.Project.config() |> Keyword.fetch!(:app)
  end

  def print_message(created_files) do
    """
    Created:

    \t#{Enum.join(created_files, "\n\t")}

    """
    |> IO.puts()
  end
end
