defmodule ToyRobotTest do
  use ExUnit.Case
  doctest ToyRobot
  import ToyRobot.Robot

  setup do
    with {:ok, _} <- init() do
      :ok
    else
      _ -> {:error, "setup error"}
    end
  end

  test "place" do
    place(1, 1, "NORTH")
    assert report() === %{x: 1, y: 1, direction: "NORTH"}
  end

  test "left" do
    place(1, 1, "NORTH")
    left()
    assert report() === %{x: 1, y: 1, direction: "WEST"}
    left()
    assert report() === %{x: 1, y: 1, direction: "SOUTH"}
    left()
    assert report() === %{x: 1, y: 1, direction: "EAST"}
    left()
    assert report() === %{x: 1, y: 1, direction: "NORTH"}
  end

  test "right" do
    place(1, 1, "NORTH")
    right()
    assert report() === %{x: 1, y: 1, direction: "EAST"}
    right()
    assert report() === %{x: 1, y: 1, direction: "SOUTH"}
    right()
    assert report() === %{x: 1, y: 1, direction: "WEST"}
    right()
    assert report() === %{x: 1, y: 1, direction: "NORTH"}
  end

  test "move" do
    place(1, 1, "NORTH")
    move()
    assert report() === %{x: 1, y: 2, direction: "NORTH"}
  end


  test "example in pronlem.md" do
# ### Example a

# PLACE 0,0,NORTH
# MOVE
# REPORT

# Expected output:

# 0,1,NORTH
    place(0,0, "NORTH")

# ### Example b

# PLACE 0,0,NORTH
# LEFT
# REPORT

# Expected output:

# 0,0,WEST

    place(0,0, "NORTH")
    left()
    assert report() === %{x: 0, y: 0, direction: "WEST"}

# ### Example c

# PLACE 1,2,EAST
# MOVE
# MOVE
# LEFT
# MOVE
# REPORT

# Expected output

# 3,3,NORTH
    place(1,2, "EAST")
    move()
    move()
    left()
    move()
    assert report() === %{x: 3, y: 3, direction: "NORTH"}
  end

  test "edge_validation" do
    place(0, 0, "SOUTH")
    move()
    assert report() === %{x: 0, y: 0, direction: "SOUTH"}
    place(0, 0, "WEST")
    move()
    assert report() === %{x: 0, y: 0, direction: "WEST"}
    place(5, 5, "NORTH")
    move()
    assert report() === %{x: 5, y: 5, direction: "NORTH"}
    place(5, 5, "EAST")
    move()
    left()
    move()
    left()
    move()
    assert report() === %{x: 4, y: 5, direction: "WEST"}
  end

  test "place_validation" do
    assert report() === "Please place your robot first!"
    move()
    left()
    assert report() === "Please place your robot first!"
    place(-1, 5, "EAST")
    assert report() === "Please place your robot first!"
    place("a", 0, "EAST")
    assert report() === "Please place your robot first!"
    place(0, "a", "EAST")
    assert report() === "Please place your robot first!"
    place(1, 1, "NORTH123123")
    assert report() === "Please place your robot first!"
  end
end
