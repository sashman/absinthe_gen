defmodule AbsintheGen do
  @moduledoc """
  Documentation for AbsintheGen.
  """

  @doc """
  Hello world.

  ## Examples

      iex> AbsintheGen.hello()
      :world

  """
  def hello do
    :world
  end

  def parent_app do
    Mix.Project.config() |> Keyword.fetch!(:app)
  end
end
