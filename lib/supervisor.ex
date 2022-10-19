defmodule MySupervisor do
  @moduledoc """
  План был обойтись без супервизора, но получилось даже объёмнее.
  + с дилайзером раньше не разбирался, поэтому не знаю пишутся ли spec на callback-и
  """
  use GenServer

  @type from :: {pid(), term()}

  @spec start_link :: :ignore | {:error, any} | {:ok, pid}
  def start_link() do
    GenServer.start_link(__MODULE__, [{FizzBuzz, :start_link, []}])
  end

  @spec list_processes(atom | pid | {atom, any} | {:via, atom, any}) :: any
  def list_processes(pid) do
    GenServer.call(pid, :list)
  end

  @spec init(any) :: {:ok, %{}}
  def init(child_spec_list) do
    Process.flag(:trap_exit, true)
    state = child_spec_list
    |> Enum.map(&start_child/1)
    |> Enum.into(%{})
    {:ok, state}
  end

  @spec handle_call(:list, from(), map()) :: {:reply, map(), map()}
  def handle_call(:list, _from, state) do
    {:reply, state, state}
  end

  @spec handle_info({atom(), pid()}, map()) :: {:noreply, map()}
  def handle_info({:EXIT, dead_pid}, state) do
    {new_pid, child_spec} = state
    |> Map.get(dead_pid)
    |> start_child()

    new_state = state
    |> Map.delete(dead_pid)
    |> Map.put(new_pid, child_spec)

    {:noreply, new_state}
  end

  @spec start_child({atom(), atom(), list()}) ::
   {pid(), {atom(), atom(), list()}}
  def start_child({module, function, args} = spec) do
    {:ok, pid} = apply(module, function, args)
    Process.link(pid)
    {pid, spec}
  end
end
