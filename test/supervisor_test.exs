defmodule MySupervisorTest do
  use ExUnit.Case

  describe "init/1" do
    test "init with empty list" do
      assert MySupervisor.init([]) == {:ok, %{}}
    end

    test "init with FizzBuzz" do
      response = MySupervisor.init([{FizzBuzz, :start_link, []}])
      assert elem(response, 0) == :ok
    end
  end
end
