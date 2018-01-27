defmodule Domain.Accounts.Counter do
  use GenServer

  ## Client Callbacks

  def start_link do
    GenServer.start_link(__MODULE__, :ok, [name: :sup_counter])
  end

  def increment_by(by) do
    GenServer.call(:sup_counter, {:increment, by})
  end

  ## Server Callbacks

  def init(:ok) do
    {:ok, %{ version: 0, count: 0 }}
  end

  # request, _from pid, state
  def handle_call({:increment, by}, _from, state) do
    version = state.version + 1
    new_count = state.count + by
    new_state = %{ version: version, count: new_count }
    # {:reply, reply, new_state}
    {:reply, new_state, new_state}
  end

end
