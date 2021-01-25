class HashSet
  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end
  
  def insert(key)
    return false if self.include?(key)
    self[key] << key
    self.count += 1
    if self.count > num_buckets
      resize!
    end
  end

  def remove(key)
    if self[key].include?(key)
      self[key].delete(key)
      self.count -= 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end


  private

  def [](num)
    self.store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old = self.store.dup 
    self.store = Array.new(num_buckets * 2) { Array.new }
    self.count = 0
    old.each do |bucket|
      bucket.each { |item| self.insert(item) }
    end
  end
end
