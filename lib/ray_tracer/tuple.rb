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
    self.class == other.class && state_equals?(other)
  end

  def +(other)
    raise RayTracer::PointAdditionError if is_point? && other.is_point?
    self.class.new(x: x + other.x, y: y + other.y, z: z + other.z, w: w + other.w)
  end

  def -(other)
    raise RayTracer::VectorPointSubtractionError if is_vector? && other.is_point?
    self.class.new(x: x - other.x, y: y - other.y, z: z - other.z, w: w - other.w)
  end

  private

    def epsilon_equals?(v, w)
      (v - w).abs < EPSILON
    end

     def state_equals?(other)
       %w(@x @y @z @w).all? { |var| epsilon_equals?(instance_variable_get(var), other.instance_variable_get(var)) }
     end
end