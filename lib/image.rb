class Image
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def get_ones
      ones = []
      @data.each_with_index do |row, row_number|
        row.each_with_index do |item, col_number|
          if item == 1
            ones << [row_number, col_number]
          end
        end
      end
      ones
    end

  def blur
    get_ones.each do |row_index, column_index|
      if row_index != 0 
       # top neigbor
      @data[row_index-1][column_index] = 1
     end
      if row_index != @data.length - 1 
       #bottom Neigbor
       @data[row_index+1][column_index] = 1
     end
      if column_index != 0 
       #left Neigbhor
       @data[row_index][column_index-1] = 1
     end
      if column_index != @data[row_index].length - 1
        # right nieghbor
       @data[row_index][column_index+1] = 1
      end  
    end
    return Image.new(@data)
  end
end

require 'spec_helper'

RSpec.describe Image, type: :model do
  describe "blurring should work" do
    it "should blur a standard image" do
      input = [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ]

      expected = [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 1, 0, 0],
        [1, 1, 1, 0],
        [0, 1, 0, 0],
        [0, 0, 0, 0]
      ]
     image = Image.new(input)
     expect(image.blur.data).to eq expected
    end
  end
end