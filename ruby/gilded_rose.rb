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
        AgedBrieUpdater.update(item)
      when BACKSTAGE_PASS
        BackstageUpdater.update(item)
      when SULFURUS 
        # do nothing
      when CONJURED
        ConjuredUpdater.update(item)
      else 
        DefaultItemUpdater.update(item)
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

class DefaultItemUpdater

  def self.update(item)
    update_sell_in(item)
    update_quality(item)
  end

  def self.update_quality(item)
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

class AgedBrieUpdater < DefaultItemUpdater
  
  def self.update(item)
    update_sell_in(item)
    update_quality(item)
  end

  private

  def self.update_quality(item)
    expired?(item) ? increase_quality(item, 2) : increase_quality(item, 1)
  end
end

class ConjuredUpdater < DefaultItemUpdater

  def self.update(item)
    update_sell_in(item)
    update_quality(item)
  end

  private

  def self.update_quality(item)
    expired?(item) ? decrease_quality(item, 4) : decrease_quality(item, 2)
  end
end

class BackstageUpdater < DefaultItemUpdater
  def self.update(item)
    update_sell_in(item)
    update_quality(item)
  end

  private

  def self.update_quality(item)
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
