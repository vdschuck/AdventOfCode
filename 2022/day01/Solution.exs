defmodule Day01 do
  def get_most_calories(file_path) do
    get_calories_per_elf(file_path)
    |> Enum.max()
    |> dbg()
  end

  def get_top_three_most_calories(file_path) do
    get_calories_per_elf(file_path)
    |> Enum.take(3)
    |> Enum.sum()
    |> dbg()
  end

  def get_calories_per_elf(file_path) do
    case read_file(file_path) do
      {:ok, result} ->
        result
        |> String.split("\n\n")
        |> Enum.map(fn element -> String.split(element, "\n") end)
        |> Enum.map(fn elf_data ->
          elf_data
          |> Enum.map(fn calories -> String.to_integer(calories) end)
          |> Enum.sum()
        end)
        |> Enum.sort(:desc)

      {:error, reason} ->
        IO.inspect(reason)
    end
  end

  def read_file(file_path) do
    File.read(file_path)
  end
end

Day01.get_most_calories("input.txt")
Day01.get_top_three_most_calories("input.txt")
