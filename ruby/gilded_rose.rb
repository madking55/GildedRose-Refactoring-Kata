class GildedRose
  BRIE = "Aged Brie"
  BACKSTAGE = "Backstage passes to a TAFKAL80ETC concert"
  SULFURAS = "Sulfuras, Hand of Ragnaros" 
  CONJURED = 'Conjured Mana Cake'

  def initialize(items)
    @items = items
  end

  def decrease_quality(item, num)
    item.quality -= num if item.quality > 0 
  end

  def increase_quality(item, num)
    item.quality += num if item.quality < 50
  end

  def decrease_sell_in(item)
    item.sell_in -= 1
  end

  def expired?(item)
    item.sell_in < 0
  end


  def update_quality
    @items.each do |item|

      decrease_sell_in(item)  if item.name != SULFURAS

        case item.name
          when BRIE
            increase_quality(item, 1) unless expired?(item)
            increase_quality(item, 2) if expired?(item)

          when BACKSTAGE
              increase_quality(item, 1) if item.sell_in > 10
              increase_quality(item, 2) if item.sell_in > 5
              increase_quality(item, 3) unless expired?(item)
              item.quality = 0 if expired?(item)

          # when CONJURED
          #   decrease_quality(item, 2)

          else
            decrease_quality(item, 1) unless expired?(item)
            decrease_quality(item, 2) if expired?(item)
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
