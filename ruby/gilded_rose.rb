class GildedRose

  AGED_BRIE = 'Aged Brie'
  BACKSTAGE_PASS = 'Backstage passes to a TAFKAL80ETC concert'
  SULFURUS = 'Sulfuras, Hand of Ragnaros'

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      
      # Brie 
      if item.name == AGED_BRIE
        increase_quality(item, 1)

      # Backstage
      elsif item.name == BACKSTAGE_PASS
        increase_quality(item, 1)
            if item.sell_in < 11
              increase_quality(item, 1)
            end
            if item.sell_in < 6
              increase_quality(item, 1)
            end

      # Sulfurus and default 
      else 
        decrease_quality(item, 1)
      end



      #  Sulfurus
      if item.name != SULFURUS
        item.sell_in = item.sell_in - 1
      end
      
      #  default item
      if item.sell_in < 0

        if item.name == AGED_BRIE
          increase_quality(item, 1)
        elsif item.name == BACKSTAGE_PASS
          decrease_quality(item, item.quality) # drops quality to 0 after concert
        elsif item.name == SULFURUS

        else
          decrease_quality(item, 1)
        end
      end
    end
  end

  def increase_quality(item, quality_raise)
    if item.quality < 50
      item.quality += quality_raise
    end
  end

  def decrease_quality(item, quality_drop)
    if item.quality > 0
      item.quality -= quality_drop
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