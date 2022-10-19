defmodule FizzBuzz do
    use GenServer

    @type from :: {pid(), term()}

    @spec init(list()) :: {:ok, list()}
    def init(v) do
      {:ok, v}
    end

    @spec start_link(list()) :: :ignore | {:error, any} | {:ok, pid}
    def start_link(init_value \\ []) do
      GenServer.start_link(__MODULE__, init_value, name: __MODULE__)
    end

    @spec get_FB_row(any) :: any
    def get_FB_row(n) do
        GenServer.call(__MODULE__, {:fb_row, n})
    end

    @spec handle_call({:fb_row, pos_integer}, from(), list()) ::
    {:reply, list(), list()}
    def handle_call({:fb_row, n}, _from, _state) when is_integer(n) and n > 0 do
        new_row = fizz(n)
        {:reply, new_row, new_row}
    end

    def handle_call({:fb_row, n}, _from, state) when is_number(n) do
      {:reply, state, state}
    end

    def handle_call({:fb_row, _n}, _from, state) do
      raise ArgumentError, message: "argument is not a number"
      {:reply, state, state}
    end

    @spec fizz(pos_integer) :: list()
    def fizz(n) when n > 0, do: _fizz(1, n, [])

    @spec _fizz(pos_integer, integer, list()) :: list()
    defp _fizz(_current, 0, result), do: Enum.reverse(result)

    defp _fizz(current, left, result) do
      next =
      cond do
        rem(current, 3) == 0 and rem(current, 5) == 0 -> "Fizzbuzz"
        rem(current, 3) == 0 -> "Fizz"
        rem(current, 5) == 0 -> "Buzz"
        true -> current
      end
      _fizz(current+1, left-1, [next | result])
    end
end
