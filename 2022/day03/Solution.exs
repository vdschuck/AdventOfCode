defmodule Rucksack do
  def calculate_priority(<<char::utf8>>) when char in ?a..?z, do: char - ?a + 1
  def calculate_priority(<<char::utf8>>) when char in ?A..?Z, do: char - ?A + 27

  def parse_line(input) do
    len = div(String.length(input), 2)
    String.split_at(input, len)
  end

  def find_common_item_type({compartment1, compartment2}) do
    compartment1 = compartment1 |> String.graphemes() |> MapSet.new()
    compartment2 = compartment2 |> String.graphemes() |> MapSet.new()
    MapSet.intersection(compartment1, compartment2) |> Enum.to_list() |> hd()
  end

  def find_group_common_item_type([group1, group2, group3]) do
    group1 = group1 |> String.graphemes() |> MapSet.new()
    group2 = group2 |> String.graphemes() |> MapSet.new()
    group3 = group3 |> String.graphemes() |> MapSet.new()

    [group1, group2, group3]
    |> Enum.reduce(fn element, acc -> MapSet.intersection(element, acc) end)
    |> Enum.to_list()
    |> hd()
  end

  def part_one(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.map(&find_common_item_type/1)
    |> Enum.map(&calculate_priority/1)
    |> Enum.sum()
  end

  def part_two(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.chunk_every(3)
    |> Enum.map(&find_group_common_item_type/1)
    |> Enum.map(&calculate_priority/1)
    |> Enum.sum()
  end
end

# Find the sum of priorities of common item types in each rucksack
# input_test.txt = 157
IO.puts("Part1: #{Rucksack.part_one("input.txt")}")

# Find the sum of priorities of common item types in each group of three rucksacks
# input_test.txt = 70
IO.puts("Part2: #{Rucksack.part_two("input.txt")}")
