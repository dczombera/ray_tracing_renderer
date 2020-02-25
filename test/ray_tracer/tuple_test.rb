require "test_helper"

class TupleTest < MiniTest::Test
  def create_vector(x, y, z)
    RayTracer::Tuple.vector(x: x, y: y, z: z)
  end

  def create_point(x, y, z)
    RayTracer::Tuple.point(x: x, y: y, z: z)
  end

  def create_tuple(x, y, z, w)
    RayTracer::Tuple.new(x: x, y: y, z: z, w:w )
  end

  def test_that_tuple_is_point
    tuple = create_point(4.3, -4.2,3.1)
    assert_equal tuple.x, 4.3
    assert_equal tuple.y, -4.2
    assert_equal tuple.z, 3.1
    assert_equal tuple.w, 1.0
    assert tuple.is_point?
    assert !tuple.is_vector?
  end

  def test_that_tuple_is_vector
    tuple = create_vector(4.3, -4.2, 3.1)
    assert_equal tuple.x, 4.3
    assert_equal tuple.y, -4.2
    assert_equal tuple.z, 3.1
    assert_equal tuple.w, 0.0
    assert tuple.is_vector?
    assert !tuple.is_point?
  end

  def test_that_tuple_factory_creates_point
    point = create_point(1.0, 2.0, 3.0)
    assert point.is_point?
    assert !point.is_vector?
  end

  def test_that_tuple_factory_creates_vector
    vector = create_vector(1.0, 2.0, 3.0)
    assert vector.is_vector?
    assert !vector.is_point?
  end

  def test_that_points_are_not_equal
    point = create_point(1.0, 0.00001, 3.0)
    other_point = create_point(1.0, 0.0, 3.0)
    assert_equal false, point == other_point

    point = create_point(1.00001, 2.0, 3.0)
    other_point = create_point(1.0, 2.0, 3.0)
    assert_equal false, point == other_point
  end

  def test_that_vectors_are_not_equal
    vector = create_vector(1.2, 2.5, 3.4)
    other_vector = create_vector(9.3, -0.7, 1.1)
    assert_equal false, vector == other_vector

    vector = create_vector(1.00001, 2.0, 3.0)
    other_vector = create_vector(1.0, 2.0, 2.0)
    assert_equal false, vector == other_vector
  end

  def test_that_points_are_equal
    point = create_point(1.0, 2.0, 3.0)
    other_point = create_point(1.0, 2.0, 3.0)
    assert point == other_point

    point = create_point(1.000001, 2.0, 3.0)
    other_point = create_point(1.0, 2.0, 3.0)
    assert point == other_point
  end

  def test_that_vectors_are_equal
    vector = create_vector(5.5, 3.3, 1.1)
    other_vector = create_vector(5.5, 3.3, 1.1)
    assert vector == other_vector

    vector = create_vector(1.1, 1.000001, 1.1)
    other_vector = create_vector(1.1, 1.0, 1.1)
    assert vector == other_vector
  end

  def test_that_point_and_vector_are_added 
    result = create_vector(1.0, 1.0, 1.0) + create_point(2.0, 2.0, 2.0)
    expected = create_point(3.0, 3.0, 3.0)
    assert_equal expected, result
  end

  def test_that_two_vectors_are_added
    result = create_vector(1.0, 1.0, 1.0) + create_vector(1.0, 1.0, 2.0)
    expected = create_vector(2.0, 2.0, 3.0)
    assert_equal expected, result
  end

  def test_that_error_is_raised_when_two_points_are_added
    point = create_point(1.2, 1.2, 1.2)
    assert_raises(RayTracer::PointAdditionError) { point + point }
  end

  def test_that_subtraction_of_two_points_results_in_vector
    result = create_point(2.0, 1.0, 3.0) - create_point(1.0, 1.0, 1.0)
    expected = create_vector(1.0, 0.0, 2.0)
    assert_equal expected, result
  end

  def test_that_subtraction_of_vector_from_point_results_in_point
    result = create_point(2.0, 2.0, 2.0) - create_vector(1.0, 1.0, 1.0)
    expected = create_point(1.0, 1.0, 1.0)
    assert_equal expected, result
  end

  def test_that_subtraction_of_two_vectors_results_in_vector
    result = create_vector(3.0, 3.0, 3.0) - create_vector(1.5, 1.5, 1.5)
    expected = create_vector(1.5, 1.5, 1.5)
    assert_equal expected, result
  end

  def test_that_error_is_raised_when_point_is_subtracted_from_vector
    assert_raises(RayTracer::VectorPointSubtractionError) { create_vector(1.0, 1.0, 1.0) - create_point(1.0, 1.0, 1.0) }
  end

  def test_that_tuple_is_negated
    negated_tuple = -create_tuple(1, -2, 3, -4)
    expected = create_tuple(-1, 2, -3, 4)
    assert_equal expected, negated_tuple
  end

  def test_multiplying_tuple_by_a_scalar
    result = create_tuple(4, 3, -2, 1) * 3
    expected = create_tuple(12, 9, -6, 3)
    assert_equal expected, result
  end

  def test_multiplying_tuple_by_a_fraction
    result = create_tuple(1, 2, -3, 4) * 0.5
        expected = create_tuple(0.5, 1, -1.5, 2)
    assert_equal expected, result
  end

  def test_that_non_scalar_input_raises_error
    assert_raises(RayTracer::NotScalarError) { create_tuple(1, 1, 1, 1) * "a" }
  end
end