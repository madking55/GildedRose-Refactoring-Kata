class GildedRose

  AGED_BRIE = 'Aged Brie'
  BACKSTAGE_PASS = 'Backstage passes to a TAFKAL80ETC concert'
  SULFURUS = 'Sulfuras, Hand of Ragnaros'

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      
      case item.name
      when AGED_BRIE
        update_aged_brie(item)
      when BACKSTAGE_PASS
        update_backstage_pass(item)
      when SULFURUS 
        update_sulfurus(item)
      else 
        update_item(item)
      end
    end
  end

  def update_aged_brie(item)
    update_sell_in(item)
    increase_quality(item, 1)
    increase_quality(item, 1) if expired?(item)
  end

  def update_backstage_pass(item)
    update_sell_in(item)
    increase_quality(item, 1)
    increase_quality(item, 1) if item.sell_in < 10
    increase_quality(item, 1) if item.sell_in < 5
    decrease_quality(item, item.quality) if expired?(item) # drops quality to 0 after concert
  end

  def update_sulfurus(item)
    # do nothing
  end

  def update_item(item)
    update_sell_in(item)
    decrease_quality(item, 1)
    decrease_quality(item, 1) if expired?(item) 
  end

  def update_sell_in(item)
    item.sell_in -= 1
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