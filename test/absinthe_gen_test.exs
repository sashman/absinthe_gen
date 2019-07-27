defmodule AbsintheGenTest do
  use ExUnit.Case
  doctest AbsintheGen

  test "greets the world" do
    assert AbsintheGen.hello() == :world
  end
end
