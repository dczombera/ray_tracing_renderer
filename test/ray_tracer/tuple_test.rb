require "test_helper"

class TupleTest < MiniTest::Test
  def test_that_tuple_is_point
    tuple = RayTracer::Tuple.new x: 4.3, y: -4.2, z: 3.1, w: 1.0
    assert_equal tuple.x, 4.3
    assert_equal tuple.y, -4.2
    assert_equal tuple.z, 3.1
    assert_equal tuple.w, 1.0
    assert tuple.is_point?
    assert !tuple.is_vector?
  end

  def test_that_tuple_is_vector
    tuple = RayTracer::Tuple.new x: 4.3, y: -4.2, z: 3.1, w: 0.0
    assert_equal tuple.x, 4.3
    assert_equal tuple.y, -4.2
    assert_equal tuple.z, 3.1
    assert_equal tuple.w, 0.0
    assert tuple.is_vector?
    assert !tuple.is_point?
  end

  def test_that_tuple_factory_creates_point
    point = RayTracer::Tuple.point(x: 1.0, y: 2.0, z: 3.0)
    assert point.is_point?
    assert !point.is_vector?
  end

  def test_that_tuple_factory_creates_vector
    vector = RayTracer::Tuple.vector(x: 1.0, y: 2.0, z: 3.0)
    assert vector.is_vector?
    assert !vector.is_point?
  end
end