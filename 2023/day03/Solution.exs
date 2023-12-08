defmodule GearRatios do
  def part_one(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.with_index()
    |> dbg()
  end
end

# input_test.txt = 4361
IO.puts("Part1: #{GearRatios.part_one("input_test.txt")}")
