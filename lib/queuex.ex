defmodule Queue do
  use GenServer

  def start_link(initial_queue) when is_list(initial_queue) do
    GenServer.start_link(__MODULE__, initial_queue)
  end

  def enqueue(pid, element), do: GenServer.call(pid, {:enqueue, element})

  def dequeue(pid), do: GenServer.call(pid, :dequeue)

  @impl true
  def init(queue), do: {:ok, queue}

  @impl true
  def handle_call({:enqueue, element}, _from, queue) do
    new_queue = queue ++ [element]
    {:reply, new_queue, new_queue}
  end

  def handle_call(:dequeue, _from, [head | tail]) do
    {:reply, head, tail}
  end

  def handle_call(:dequeue, _from, []) do
    {:reply, nil, []}
  end
end
