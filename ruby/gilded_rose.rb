class GildedRose

  AGED_BRIE = 'Aged Brie'
  BACKSTAGE_PASS = 'Backstage passes to a TAFKAL80ETC concert'
  SULFURUS = 'Sulfuras, Hand of Ragnaros'

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|

      if item.name != SULFURUS
        item.sell_in = item.sell_in - 1
      end

      case item.name
      when AGED_BRIE
        increase_quality(item, 1)
      when BACKSTAGE_PASS
        increase_quality(item, 1)
            if item.sell_in < 10
              increase_quality(item, 1)
            end
            if item.sell_in < 5
              increase_quality(item, 1)
            end
      when SULFURUS
        #  do nothing
      else 
        decrease_quality(item, 1)
      end

      #  default item
      if expired?(item)
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

  def expired?(item)
    item.sell_in < 0
  end

  def increase_quality(item, quality_raise)
    item.quality += quality_raise if item.quality < 50
  end

  def decrease_quality(item, quality_drop)
    item.quality -= quality_drop if item.quality > 0
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