class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|

      # Brie and Backstage
      if item.name == "Aged Brie" || item.name == "Backstage passes to a TAFKAL80ETC concert"
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      # Sulfurus and default 
      # elsif item.quality > 0
      #   item.quality = item.quality - 1 
      # end



      #  Sulfurus
      if item.name == "Sulfuras, Hand of Ragnaros"
        break
      elsif item.quality > 0
        item.quality = item.quality - 1 
      else
        item.sell_in = item.sell_in - 1
      end
      
      #  default item
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      elsif item.quality > 0
        item.quality = item.quality - 1 
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end