defmodule ToyRobot.Robot do
  alias ToyRobot.Placement
  import ToyRobot.Placement
  @directions ["NORTH", "EAST", "SOUTH", "WEST"]

  def init() do
    Agent.start_link(fn -> %Placement{} end, name: :placement)
  end

  def place(x, y, direction) do
    update_placement(%Placement{x: x, y: y, direction: direction})
  end

  def move() do
    case get_placement.direction do
      "NORTH" -> update_placement(:y, get_placement.y + 1)
      "EAST"  -> update_placement(:x, get_placement.x + 1)
      "SOUTH" -> update_placement(:y, get_placement.y - 1)
      "WEST"  -> update_placement(:x, get_placement.x - 1)
      _ -> nil
    end
  end

  def left() do
    update_direction(-1)
  end

  def right() do
    update_direction(1)
  end

  def report() do
    with placement when placement !== %Placement{x: nil, y: nil, direction: nil} <- get_placement()
    do
      %{x: get_placement.x, y: get_placement.y, direction: get_placement.direction}
    else
      _ -> "Please place your robot first!"
    end
  end

  def update_direction(cal) do
    with placement when placement !== %Placement{x: nil, y: nil, direction: nil} <- get_placement(),
      index when index < 4 <- Enum.find_index(@directions, &(&1 === placement.direction)) + cal,
      new_direction <- Enum.at(@directions, index)
    do
      update_placement(:direction, new_direction)
    else
      # When reaching the end of the list, euqals to back to start of the list
      4 -> update_direction(-3)
      _ -> nil
    end
  end
end