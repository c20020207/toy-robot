defmodule ToyRobot.Placement do
  defstruct x: nil, y: nil, direction: nil
  def update_placement(key, value) do
    Map.put(get_placement, key, value) |> update_placement
  end
  def update_placement(new_placement) do
    Agent.update(:placement, fn placement -> new_placement end)
  end
  def get_placement() do
    Agent.get(:placement, fn placement -> placement end)
  end
end
