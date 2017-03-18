defmodule Portal do

  defstruct [:left, :right]

  def shoot(color) do
    Supervisor.start_child(Portal.Supervisor, [color])
  end

  def transfer(left, right, data) do
    for item <- data do
      Portal.Door.rpush(left, item)
    end
    %Portal{left: left, right: right}
  end

  def push_right(portal) do
    case Portal.Door.rpop(portal.left) do
      nil -> nil
      d -> Portal.Door.lpush(portal.right, d)
    end
    portal
  end

end

defimpl Inspect, for: Portal do
  def inspect(%Portal{left: l, right: r}, _) do
    left_door = inspect(l)
    right_door = inspect(r)

    left_data = inspect(Portal.Door.get(l))
    right_data = inspect(Portal.Door.get(r))

    """
    #Portal<
      #{left_door} => #{left_data}
      #{right_door} => #{right_data}
    >
    """
  end
end
