defmodule Trebuchet do
  def part_one(filename) do
    regex_pattern = ~r/\d/

    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> solve_calibration(regex_pattern)
    |> Enum.sum()
  end

  def part_two(filename) do
    regex_pattern =
      ~r/\d|(?=(one))|(?=(two))|(?=(three))|(?=(four))|(?=(five))|(?=(six))|(?=(seven))|(?=(eight))|(?=(nine))/

    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> solve_calibration(regex_pattern)
    |> Enum.sum()
  end

  defp convert_string_to_number("one"), do: 1
  defp convert_string_to_number("two"), do: 2
  defp convert_string_to_number("three"), do: 3
  defp convert_string_to_number("four"), do: 4
  defp convert_string_to_number("five"), do: 5
  defp convert_string_to_number("six"), do: 6
  defp convert_string_to_number("seven"), do: 7
  defp convert_string_to_number("eight"), do: 8
  defp convert_string_to_number("nine"), do: 9
  defp convert_string_to_number(num), do: String.to_integer(num)

  defp solve_calibration(input, regex) do
    input
    |> Enum.map(fn line ->
      numbers =
        regex
        |> Regex.scan(line)
        |> List.flatten()
        |> Enum.reject(&(&1 == ""))
        |> Enum.map(&convert_string_to_number/1)

      List.first(numbers) * 10 + List.last(numbers)
    end)
  end
end

# input_test.txt = 77
IO.puts("Part1: #{Trebuchet.part_one("input.txt")}")

# input_test2.txt = 281
IO.puts("Part2: #{Trebuchet.part_two("input.txt")}")
