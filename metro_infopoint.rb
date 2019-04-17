class MetroInfopoint
  def initialize(path_to_timing_file:, path_to_lines_file:)
    load_files(path_to_timing_file, path_to_lines_file)
    calculate_prices_and_times()
  end

  def calculate(from_station:, to_station:)
    { price: calculate_price(from_station: from_station, to_station: to_station),
      time: calculate_time(from_station: from_station, to_station: to_station) }
  end

  def calculate_price(from_station:, to_station:)
    from_index = @stations.index(from_station.to_sym)
    to_index = @stations.index(to_station.to_sym)
    @prices[from_index][to_index].round(5)
  end

  def calculate_time(from_station:, to_station:)
    from_index = @stations.index(from_station.to_sym)
    to_index = @stations.index(to_station.to_sym)
    @times[from_index][to_index].round(5)
  end

  private

  def load_files(path_to_timing_file, path_to_lines_file)
    timing_data = YAML.load_file(path_to_timing_file)['timing']
    stations_data = YAML.load_file(path_to_lines_file)['stations']
    @stations = stations_data.keys.map { |k| k.to_sym }

    init_prices_and_times(timing_data)
  end

  def init_prices_and_times(timing_data)
    n = @stations.length
    @prices = Array.new(n) { Array.new(n, -1) }
    @times = Array.new(n) { Array.new(n, -1) }
  
    timing_data.each do |k|
      i = @stations.index(k['start'])
      j = @stations.index(k['end'])
      @prices[i][j] = @prices[j][i] = k['price']
      @times[i][j] = @times[j][i] = k['time']
    end
  end

  def calculate_prices_and_times
    n = @stations.length
    n.times do |k|
      n.times do |i|
        n.times do |j|
          set_minimum(@prices, i, j, k)
          set_minimum(@times, i, j, k)
        end
      end
    end
  end

  def set_minimum(matr, i, j, k)
    if matr[i][k] != -1 && matr[k][j] != -1
      if matr[i][j] == -1 || matr[i][j] > matr[i][k] + matr[k][j]
        matr[i][j] = matr[i][k] + matr[k][j]
      end
    end
  end
end
