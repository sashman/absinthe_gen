defmodule AbsintheGen do
  @moduledoc """
  Documentation for AbsintheGen.
  """

  def parent_app do
    Mix.Project.config() |> Keyword.fetch!(:app)
  end
end
