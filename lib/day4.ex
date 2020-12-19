defmodule Day4 do
  def solve(passports) do
    Enum.reduce passports, 0, fn passport, acc ->
      if valid?(passport) do
        acc + 1
      else
        acc
      end
    end
  end

  # byr (Birth Year) - four digits; at least 1920 and at most 2002.
  # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
  # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
  # hgt (Height) - a number followed by either cm or in:
  #     If cm, the number must be at least 150 and at most 193.
  #     If in, the number must be at least 59 and at most 76.
  # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
  # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
  # pid (Passport ID) - a nine-digit number, including leading zeroes.
  # cid (Country ID) - ignored, missing or not.
  def valid?(passport) do
    pass = passport |> convert_to_map()

    requiredFields = ["byr", "cid", "ecl", "eyr", "hcl", "hgt", "iyr", "pid"]
    providedFields = pass |> Map.keys
    missingFields = requiredFields -- providedFields

    if missingFields == [] || missingFields == ["cid"] do
      valid_year?(pass["byr"], 1920, 2002) && valid_year?(pass["iyr"], 2010, 2020) &&
        valid_year?(pass["eyr"], 2020, 2030) && valid_height?(pass["hgt"]) &&
          valid_hair_color?(pass["hcl"]) && valid_eye_color?(pass["ecl"]) &&
            valid_passport_id?(pass["pid"])
    else
      false
    end
  end

  def convert_to_map(passport) do
    Enum.reduce passport, %{}, fn pair, pass ->
      [key, value] = String.split(pair, ":")
      Map.put(pass, key, value)
    end
  end

  def valid_year?(input, min, max) do
    if input =~ ~r/^\d{4}$/ do
      year = String.to_integer(input)
      year >= min && year <= max
    else
      false
    end
  end

  def valid_passport_id?(input) do
    input =~ ~r/^\d{9}$/
  end

  def valid_eye_color?(input) do
    input =~ ~r/^(amb|blu|brn|gry|grn|hzl|oth)$/
  end

  def valid_hair_color?(input) do
    input =~ ~r/^#[0-9a-f]{6}$/
  end

  def valid_height?(input) do
    case Regex.run(~r/^(\d{2,3})(cm|in)$/, input) do
      [_, height, "cm"] ->
        h = String.to_integer(height)
        h >= 150 && h <= 193
      [_, height, "in"] ->
        h = String.to_integer(height)
        h >= 59 && h <= 76
      nil ->
        false
    end
  end
end
