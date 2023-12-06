defmodule CubeConundrum do
  def part_one(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> parse_game()
      |> get_id_of_possible_games()
    end)
    |> Enum.sum()
  end

  def part_two(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> parse_game()
      |> multiply_highest_values()
    end)
    |> Enum.sum()
  end

  defp parse_game(line) do
    [label, game] = String.split(line, ":", trim: true)

    IO.inspect(line, label: "linha ")

    game_id =
      label
      |> String.replace("Game ", "")
      |> String.to_integer()

    rounds =
      game
      |> String.split(";", trim: true)
      |> Enum.map(&parse_rounds/1)

    {game_id, rounds}
  end

  defp parse_rounds(rounds) do
    rounds
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split(&1, " "))
    |> Enum.map(fn [amount, colour] ->
      {String.to_atom(colour), String.to_integer(amount)}
    end)
    |> Map.new()
  end

  defp get_id_of_possible_games({game_id, rounds}) do
    max_red = 12
    max_green = 13
    max_blue = 14

    is_possible =
      Enum.all?(rounds, fn round ->
        Map.get(round, :red, 0) <= max_red &&
          Map.get(round, :green, 0) <= max_green &&
          Map.get(round, :blue, 0) <= max_blue
      end)

    if is_possible do
      game_id
    else
      0
    end
  end

  defp multiply_highest_values({_, rounds}) do
    max_scores =
      Enum.reduce(rounds, %{}, fn round, acc ->
        Map.merge(acc, round, fn _, score1, score2 -> max(score1, score2) end)
      end)

    Map.get(max_scores, :red) * Map.get(max_scores, :green) * Map.get(max_scores, :blue)
  end
end

# input_test.txt = 8
IO.puts("Part1: #{CubeConundrum.part_one("input.txt")}")

# input_test.txt = 2286
IO.puts("Part2: #{CubeConundrum.part_two("input.txt")}")
