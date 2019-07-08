defmodule ToyRobot.Placement do
  defstruct x: nil, y: nil, direction: nil
  @directions ["NORTH", "EAST", "SOUTH", "WEST"]

  @doc """
  Update by key value
  """
  def update_placement(key, value) do
    Map.put(get_placement, key, value) |> update_placement
  end
  def update_placement(new_placement) do
    if (is_valid_placement?(new_placement)) do
      Agent.update(:placement, fn placement -> new_placement end)
    else
      {:error, "Can not update placement"}
    end
  end
  @doc """
  Get
  """
  def get_placement() do
    Agent.get(:placement, fn placement -> placement end)
  end
  @doc """
  Validation
  As per in requirement, all invalid call will be ignored
  """
  def is_valid_placement?(placement) do
    is_number(placement.x) and placement.x in 0..5
    and is_number(placement.y) and placement.y in 0..5
    and placement.direction in @directions
  end

end
