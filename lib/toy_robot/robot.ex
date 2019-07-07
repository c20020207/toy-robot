defmodule ToyRobot.Robot do
  alias ToyRobot.Placement

  @directions [:north, :east, :south, :west]

  def init() do
    Agent.start_link(fn -> %Placement{} end, name: :placement)
  end

  def place(x, y, direction) do

  end

  def move() do

  end

  def left() do

  end

  def right() do

  end

  def report do

  end
end