module RayTracer
  class TupleError < StandardError;end
  class PointAdditionError < TupleError
    def message
      "Addition of two points is an invalid operation!"
    end
  end
end

