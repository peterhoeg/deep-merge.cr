class Hash(K, V)
  # Merges *other* and self and returns a new Hash with the combined types of
  # *other* and self
  def deep_merge(other : Hash(L, W)) forall L, W
    target = Hash(K | L, V | W).new
    target.merge! self

    target.deep_merge! other
  end

  # Merges *other* into self
  def deep_merge!(other : Hash(L, W)) forall L, W
    other.keys.each do |key|
      # keys only in other
      if !self[key]?
        self[key] = other[key]
        next
      end

      # merge if both are hashes
      me = self[key]
      them = other[key]
      if me.is_a?(Hash) && them.is_a?(Hash)
        self[key] = me.deep_merge!(them)
        next
      end

      # otherwise take from other
      self[key] = other[key]
    end

    self
  end
end
