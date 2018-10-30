defmodule NatlangTest do
  use ExUnit.Case
  doctest Natlang

  test "greets the world" do
    assert Natlang.hello() == :world
  end
end
