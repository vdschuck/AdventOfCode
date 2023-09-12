defmodule CampCleanUp do
  def parse_content(filename) do
    filename
    |> File.read!()
    |> String.split(["-", ",", "\n"], trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Enum.chunk_every(2)
  end

  def part_one(content) do
    content
    |> Enum.filter(fn row -> fully_overlap(row) end)
    |> Enum.count()
  end

  def part_two(content) do
    content
    |> Enum.filter(fn row -> partially_overlap(row) end)
    |> Enum.count()
  end

  defp fully_overlap([[a1, a2], [b1, b2]]) do
    (a1 <= b1 and a2 >= b2) or (a1 >= b1 and a2 <= b2)
  end

  defp partially_overlap([[a1, a2], [b1, b2]]) do
    (a1 <= b1 and b1 <= a2) or (b1 <= a1 and a1 <= b2)
  end
end

part_one = CampCleanUp.parse_content("input.txt") |> CampCleanUp.part_one()

# input_test.txt = 2
# 518
IO.puts("Part1: #{part_one}")

part_two = CampCleanUp.parse_content("input.txt") |> CampCleanUp.part_two()

# input_test.txt = 4
# 909
IO.puts("Part2: #{part_two}")
