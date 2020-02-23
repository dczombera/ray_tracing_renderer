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

  def test_that_tuples_are_equal
    tuple = RayTracer::Tuple.new(x: 1.0, y: 2.0, z: 3.0, w: 0.0)
    other_tuple = RayTracer::Tuple.new(x: 1.0, y: 2.2, z: 3.0, w: 0.0)
    assert_equal false, tuple == other_tuple

    tuple = RayTracer::Tuple.new(x: 1.1, y: 2.0, z: 3.0, w: 0.0)
    other_tuple = RayTracer::Tuple.new(x: 1.2, y: 2.0, z: 3.0, w: 0.0)
    assert_equal false, tuple == other_tuple

    tuple = RayTracer::Tuple.new(x: 1.0, y: 2.0, z: 3.0, w: 0.0)
    other_tuple = RayTracer::Tuple.new(x: 1.0, y: 2.0, z: 2.0, w: 0.0)
    assert_equal false, tuple == other_tuple

    tuple = RayTracer::Tuple.new(x: 1.00001, y: 2.0, z: 3.0, w: 1.0)
    other_tuple = RayTracer::Tuple.new(x: 1.0, y: 2.0, z: 3.0, w: 1.0)
    assert_equal false, tuple == other_tuple
  end

  def test_that_tuples_are_not_equal
    tuple = RayTracer::Tuple.new(x: 1.0, y: 2.0, z: 3.0, w: 0.0)
    other_tuple = RayTracer::Tuple.new(x: 1.0, y: 2.0, z: 3.0, w: 0.0)
    assert tuple == other_tuple

    tuple = RayTracer::Tuple.new(x: 1.0, y: 2.0, z: 3.0, w: 1.0)
    other_tuple = RayTracer::Tuple.new(x: 1.0, y: 2.0, z: 3.0, w: 1.0)
    assert tuple == other_tuple

    tuple = RayTracer::Tuple.new(x: 1.000001, y: 2.0, z: 3.0, w: 1.0)
    other_tuple = RayTracer::Tuple.new(x: 1.0, y: 2.0, z: 3.0, w: 1.0)
    assert tuple == other_tuple
  end

  def test_that_point_and_vector_are_added 
    result = RayTracer::Tuple.vector(x: 1.0, y: 1.0, z: 1.0) + RayTracer::Tuple.point(x: 2.0, y: 2.0, z: 2.0)
    expected = RayTracer::Tuple.point(x: 3.0, y: 3.0, z: 3.0)
    assert_equal expected, result
  end

  def test_that_two_vectors_are_added
    result = RayTracer::Tuple.vector(x: 1.0, y: 1.0, z: 1.0) + RayTracer::Tuple.vector(x: 1.0, y: 1.0, z: 2.0)
    expected = RayTracer::Tuple.vector(x: 2.0, y: 2.0, z: 3.0)
    assert_equal expected, result
  end

  def test_that_error_is_raised_when_two_points_are_added
    point = RayTracer::Tuple.point(x: 1.2, y: 1.2, z: 1.2)
    assert_raises(RayTracer::PointAdditionError) { point + point }
  end
end