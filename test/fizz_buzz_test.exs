defmodule FizzBuzzTest do
  @moduledoc """
  Раньше не тестировал GenServer, но подозреваю, что лучше всего тестировать callback-и напрямую
  """
  use ExUnit.Case

  describe "init/1" do
    test "init with empty list" do
      assert FizzBuzz.init([]) == {:ok, []}
    end

    test "init with non empty list" do
      assert FizzBuzz.init([1, 2]) == {:ok, [1, 2]}
    end
  end

  describe "handle_call/3" do
    test "get_FB_row with pos_integer" do
      assert FizzBuzz.handle_call({:fb_row, 5}, [], []) == {:reply, [1, 2, "Fizz", 4, "Buzz"], [1, 2, "Fizz", 4, "Buzz"]}
    end

    test "get_FB_row with zero" do
      assert FizzBuzz.handle_call({:fb_row, 0}, [], []) == {:reply, [], []}
    end

    test "get_FB_row with not pos number " do
      assert FizzBuzz.handle_call({:fb_row, -5}, [], []) == {:reply, [], []}
    end

    test "get_FB_row with not a number" do
      assert_raise ArgumentError, "argument is not a number", fn -> FizzBuzz.handle_call({:fb_row, "ttt"}, [], []) end
    end
  end
end
