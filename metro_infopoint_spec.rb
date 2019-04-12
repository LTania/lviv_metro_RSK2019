require 'rspec'
require './metro_infopoint'

FROM_TO_PAIRS = [
  { from_station:'shevchenkivska', to_station: 'kiborgiv',   calculated_time: 3 + 6 + 2, calculated_price: 2.5 + 3 + 1 },
  { from_station:'lemberska',      to_station: 'nezalezhna', calculated_time: 6 + 2 + 6 + 3, calculated_price: 3 + 1 + 3 + 2.5 },
  { from_station:'konotopska',     to_station: 'banderivska', calculated_time: 3 + 3, calculated_price: 2.5 + 2.5 }
]

class MetroInfopointDouble
  def initialize(path_to_timing_file:, path_to_lines_file:)
    # initialization here
  end

  def calculate(from_station:, to_station:)
    { price: calculate_price(from_station: from_station, to_station: to_station),
      time: calculate_time(from_station: from_station, to_station: to_station) }
  end

  def calculate_price(from_station:, to_station:)
    FROM_TO_PAIRS.find { |e| e[:from_station] == from_station && e[:to_station] == to_station }[:calculated_price]
  end

  def calculate_time(from_station:, to_station:)
    FROM_TO_PAIRS.find { |e| e[:from_station] == from_station && e[:to_station] == to_station }[:calculated_time]
  end
end



RSpec.describe MetroInfopoint do
  let(:object) { MetroInfopoint.new(path_to_timing_file: '', path_to_lines_file: '') }

  describe 'valid class' do
    it { expect(MetroInfopoint).to respond_to(:new) }
    it { expect(object).to respond_to(:calculate_time, :calculate_price, :calculate) }
  end

  describe '#calculate_price' do
    FROM_TO_PAIRS.each do |e|
      it { expect(object.calculate_price(from_station: e[:from_station], to_station: e[:to_station])).to eq(e[:calculated_price]) }
    end
  end

  describe '#calculate_time' do
    FROM_TO_PAIRS.each do |e|
      it { expect(object.calculate_time(from_station: e[:from_station], to_station: e[:to_station])).to eq(e[:calculated_time]) }
    end
  end

  describe '#calculate' do
    FROM_TO_PAIRS.each do |e|
      result = { price: e[:calculated_price], time: e[:calculated_time] }
      it { expect(object.calculate(from_station: e[:from_station], to_station: e[:to_station])).to eq(result) }
    end
  end
end
