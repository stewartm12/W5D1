class MaxIntSet
  attr_reader :max, :store

  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" if num < 0 || num > @max
    self.store[num] = true
  end

  def remove(num)
    self.store[num] = false 
  end

  def include?(num)
    self.store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  attr_reader :store
  
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    self.store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :count, :store 

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return false if self.include?(num)
    self[num] << num
    self.count += 1
  end

  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
      self.count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    self.store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    # self.store.concat(Array.new(num_buckets) { Array.new }) 
    # self.store.each do |bucket|
    #   if bucket.length > 1
    #     self.insert(bucket.pop)
    #     count -= 1
    #   end
    # end
    old = self.store.dup 
    self.store = Array.new(self.num_buckets * 2) { Array.new }
    old.each do |bucket|
      bucket.each { |item| self.insert(item) }
    end
  end
end
