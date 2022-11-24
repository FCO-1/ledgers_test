defmodule EdgeGatewayTest do
  use ExUnit.Case
  doctest EdgeGateway

  test "greets the world" do
    assert EdgeGateway.hello() == :world
  end
end
