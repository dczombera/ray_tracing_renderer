class RayTracer::Tuple
  attr_accessor :x, :y, :z, :w

  EPSILON = 1.0e-05

  # Factory methods
  class << self
    def point(x: 0.0, y: 0.0, z: 0.0)
      new(x: x, y: y, z: z, w: 1.0)
    end

    def vector(x: 0.0, y: 0.0, z: 0.0)
      new(x: x, y: y, z: z, w: 0.0)
    end
  end

  def initialize(x:, y:, z:, w:)
    self.x = x
    self.y = y
    self.z = z
    self.w = w
  end

  def is_point?
    w == 1.0
  end

  def is_vector?
    w == 0.0
  end

  def ==(other)
    epsilon_equals(x, other.x) && epsilon_equals(y, other.y) && epsilon_equals(z, other.z) && epsilon_equals(w, other.w)
  end

  private

    def epsilon_equals(v, w)
      (v - w).abs < EPSILON
    end
end