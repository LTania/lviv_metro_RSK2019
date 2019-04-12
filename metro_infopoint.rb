class MetroInfopoint
  def initialize(path_to_timing_file:, path_to_lines_file:)
    # initialization here
  end

  def calculate(from_station:, to_station:)
    { price: calculate_price(from_station: from_station, to_station: to_station),
      time: calculate_time(from_station: from_station, to_station: to_station) }
  end

  def calculate_price(from_station:, to_station:)
    # your implementation here
  end

  def calculate_time(from_station:, to_station:)
    # your implementation here
  end
end
