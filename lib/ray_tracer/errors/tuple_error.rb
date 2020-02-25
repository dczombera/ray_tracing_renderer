module RayTracer
  class TupleError < StandardError;end
  class PointAdditionError < TupleError
    def message
      "Addition of two points is an invalid operation!"
    end
  end

  class VectorPointSubtractionError < TupleError
    def message
      "Subtraction of point from vector is an invalid operation!"
    end
  end

  class NotScalarError < TupleError
    attr_reader :object

    def initialize(object)
      @object = object
    end

    def message
      "#{object} needs to be of type Numeric"
    end
  end
end

