defmodule Assignment do
  def count_contained_pairs(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.count(&contains_pair?/1)
  end

  defp contains_pair?(assignment) do
    [range1_str, range2_str] = String.split(assignment, ",")
    [range1, range2] = Enum.map([range1_str, range2_str], &parse_range/1)
    is_contained?(range1, range2) or is_contained?(range2, range1)
  end

  defp parse_range(range_str) do
    [start_str, stop_str] = String.split(range_str, "-")
    {String.to_integer(start_str), String.to_integer(stop_str)}
  end

  defp is_contained?({start1, stop1}, {start2, stop2}) when start1 <= start2 and stop1 >= stop2,
    do: true

  defp is_contained?(_, _), do: false
end

input = """
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
"""

IO.puts(
  "Number of assignment pairs where one range fully contains the other: #{Assignment.count_contained_pairs(input)}"
)
