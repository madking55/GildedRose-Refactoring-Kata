class GildedRose

  AGED_BRIE = 'Aged Brie'
  BACKSTAGE_PASS = 'Backstage passes to a TAFKAL80ETC concert'
  SULFURUS = 'Sulfuras, Hand of Ragnaros'
  CONJURED = 'Conjured Mana Cake' 

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      
      case item.name
      when AGED_BRIE
        AgedBrie.update_item(item)
      when BACKSTAGE_PASS
        Backstage.update_item(item)
      when SULFURUS 
        # do nothing
      when CONJURED
        Conjured.update_item(item)
      else 
        ItemUpdater.update_item(item)
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

class ItemUpdater
  def self.update_item(item)
    update_sell_in(item)
    expired?(item) ? decrease_quality(item, 2) : decrease_quality(item, 1)
  end

  def self.update_sell_in(item)
    item.sell_in -= 1
  end

  def self.expired?(item)
    item.sell_in < 0
  end

  def self.increase_quality(item, quality_raise)
    item.quality += quality_raise 
    item.quality = 50 if item.quality > 50 
  end

  def self.decrease_quality(item, quality_drop)
    item.quality -= quality_drop
    item.quality = 0 if item.quality <= 0
  end
end

class Sulfuras
end

class AgedBrie < ItemUpdater
  def self.update_item(item)
    update_sell_in(item)
    increase_quality(item, 1)
    increase_quality(item, 1) if expired?(item)
  end
end

class Conjured < ItemUpdater
  def self.update_item(item)
    update_sell_in(item)
    expired?(item) ? decrease_quality(item, 4) : decrease_quality(item, 2)
  end
end

class Backstage < ItemUpdater
  def self.update_item(item)
    update_sell_in(item)

    if item.sell_in >= 10
      increase_quality(item, 1)
    elsif item.sell_in >= 5
      increase_quality(item, 2) 
    elsif item.sell_in < 5 && !expired?(item)
      increase_quality(item, 3)
    elsif expired?(item)
      decrease_quality(item, item.quality) 
    end
  end
end
