defmodule Portal.Door do
  def start_link(color) do
    Agent.start_link(fn -> [] end, name: color)
  end

  def get(door) do
    Agent.get(door, fn list -> list end)
  end

  def lpush(door, value) do
    Agent.update(door, fn list -> List.insert_at(list, 0, value) end)
  end

  def rpush(door, value) do
    Agent.update(door, fn list -> List.insert_at(list, -1, value) end)
  end

  def lpop(door) do
    Agent.get_and_update(door, fn list -> 
      List.pop_at(list, 0)
    end)
  end

  def rpop(door) do
    Agent.get_and_update(door, fn list ->
      List.pop_at(list, -1)
    end)
  end
end
