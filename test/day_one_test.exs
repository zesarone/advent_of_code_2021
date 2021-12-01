defmodule DayOneTest do
  use ExUnit.Case
  doctest DayOne

  test "greets the world" do
    assert DayOne.data() |> DayOne.count_greater_then_pre() == 1692
    assert DayOne.data() |> DayOne.sum_3_conseq() |> DayOne.count_greater_then_pre() == 1724
  end
end
