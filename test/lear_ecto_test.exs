defmodule LearEctoTest do
  use ExUnit.Case
  doctest LearEcto

  test "greets the world" do
    assert LearEcto.hello() == :world
  end
end
