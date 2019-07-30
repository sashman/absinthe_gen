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
    for {app, _, _} <- Application.loaded_applications(),
        deps = Application.spec(app)[:applications],
        :absinthe_gen in deps do
      app
    end
    |> case do
      [] -> :absinthe_gen
      [first | _] -> first
    end
  end
end
