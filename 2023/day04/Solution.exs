defmodule Scratchcards do
  def part_one(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> parse_numbers()
    end)
    |> Enum.map(&calculate_points/1)
    |> Enum.sum()
  end

  def part_two(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> parse_numbers()
    end)
    |> Enum.map(fn num_winners -> {_card_copies = 1, num_winners} end)
    |> process_cards()
    |> Enum.sum()
  end

  defp parse_numbers(line) do
    [_game_id, winning_numbers, my_numbers] = String.split(line, [": ", " | "])

    winning_numbers =
      winning_numbers
      |> String.split(" ", trim: true)
      |> MapSet.new()

    my_numbers =
      my_numbers
      |> String.split(" ", trim: true)
      |> MapSet.new()

    MapSet.intersection(winning_numbers, my_numbers) |> MapSet.size()
  end

  defp calculate_points(0), do: 0
  defp calculate_points(num_winners), do: round(2.0 ** (num_winners - 1))

  def process_cards([]), do: []

  def process_cards([{card_copies, num_winners} | rest]) do
    {to_copy, left_alone} = Enum.split(rest, num_winners)

    copied =
      Enum.map(to_copy, fn {child_num_copies, num_winners} ->
        {card_copies + child_num_copies, num_winners}
      end)

    [card_copies | process_cards(copied ++ left_alone)]
  end
end

# input_test.txt = 13
IO.puts("Part1: #{Scratchcards.part_one("input_test.txt")}")

# input_test.txt = 30
IO.puts("Part2: #{Scratchcards.part_two("input_test.txt")}")
