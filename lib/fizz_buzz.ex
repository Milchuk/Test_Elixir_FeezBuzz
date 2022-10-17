defmodule FizzBuzz do
    use GenServer

    def init(:ok) do
      {:ok, %{}}
    end

    def start_link do
      GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
    end

    def get_FB_row(n) do
        GenServer.call(__MODULE__, {:fb_row, n})
    end

    def handle_call({:fb_row, n}, _from, state) do
        {:reply, fizz(n), state}
    end

    def fizz(n) when n > 0, do: _fizz(1, n, [])

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
