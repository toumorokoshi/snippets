class CsvRow

  def initialize(headers, row)
    headers = headers.zip(row)
    @values = headers.inject({}) { |hash, value| hash[value[0].downcase] = value[1]; hash }
  end

  def method_missing name, *args
    @values[name.to_s] if @values.has_key?(name.to_s)
  end

end

module ActsAsCsv

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    
    def acts_as_csv
      include InstanceMethods
    end
    
  end

  module InstanceMethods
    
    def read
      @csv_contents = []
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(filename)

      @headers = file.gets.chomp.split(', ')
      file.each do |row|
        @csv_contents << row.chomp.split(', ')
      end

    end

    def each 
      @csv_contents.each do |raw_row|
        yield CsvRow.new(@headers, raw_row)
      end
    end

    attr_accessor :headers, :csv_contents

    def initialize
      read
    end

  end

end

class RubyCsv

  include ActsAsCsv

  acts_as_csv

end

m = RubyCsv.new

puts m.headers.inspect
puts m.csv_contents.inspect
m.each { |row| p row.description }
