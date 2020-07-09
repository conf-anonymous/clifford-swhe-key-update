require Dir.pwd + "/test/test_helper"

class TestMultivector3DMod < Minitest::Test

  def test_initialization
    input = Array.new(8){ Clifford::Tools.random_number(8)}
    m = Clifford::Multivector3DMod.new input, 257

    assert_equal Clifford::Multivector3DMod, m.class
    assert_equal input[0], m.e0
    assert_equal input[1], m.e1
    assert_equal input[2], m.e2
    assert_equal input[3], m.e3
    assert_equal input[4], m.e12
    assert_equal input[5], m.e13
    assert_equal input[6], m.e23
    assert_equal input[7], m.e123
  end

  def test_bad_initialization

    error2 = assert_raises(Multivector3DError) do
      m = Clifford::Multivector3DMod.new [], 7
    end

    error3 = assert_raises(Multivector3DError) do
      m = Clifford::Multivector3DMod.new 2, 7
    end

    error4 = assert_raises(Multivector3DError) do
      m = Clifford::Multivector3DMod.new Array.new(7){ Clifford::Tools.random_number(8)}, 257
    end

    expected_message = "Invalid input. Input must be an array of 8 numeric entries."

    assert_equal expected_message, error2.message
    assert_equal expected_message, error3.message
    assert_equal expected_message, error4.message
  end

  def test_to_s
    input = Array.new(8){ Clifford::Tools.random_number(8)}
    m = Clifford::Multivector3DMod.new input, 257

    m_to_s = m.to_s
    expected_m_to_s = "#{input[0]}e0 + #{input[1]}e1 + #{input[2]}e2 + #{input[3]}e3 + #{input[4]}e12 + #{input[5]}e13 + #{input[6]}e23 + #{input[7]}e123"

    assert_equal expected_m_to_s, m_to_s
  end

  def test_data
    input = Array.new(8){ Clifford::Tools.random_number(8)}
    m = Clifford::Multivector3DMod.new input, 257

    expected_data = input

    assert_equal expected_data, m.data
  end

  def test_geometric_product
    m = Clifford::Multivector3DMod.new [2,3,4,5,6,7,8,9], 257
    mm = m.gp(m)
    expected_data = [81, 125, 142, 169, 114, 213, 86, 88]

    assert_equal expected_data, mm.data
  end

  def test_clifford_conjugation
    m = Clifford::Multivector3DMod.new [2,3,4,5,6,7,8,9], 257

    expected_data = [2, 254, 253, 252, 251, 250, 249, 9]

    assert_equal expected_data, m.cc.data
  end

  def test_reverse
    m = Clifford::Multivector3DMod.new [2,3,4,5,6,7,8,9], 257

    expected_data = [2, 3, 4, 5, 251, 250, 249, 248]

    assert_equal expected_data, m.reverse.data
  end

  def test_amplitude_squared
    m = Clifford::Multivector3DMod.new [2,3,4,5,6,7,8,9], 257

    expected_data = [22, 0, 0, 0, 0, 0, 0, 241]

    assert_equal expected_data, m.gp(m.cc).data
  end

  def test_rationalize
    m = Clifford::Multivector3DMod.new [2,3,4,5,6,7,8,9], 257

    expected_data = [226, 0, 0, 0, 0, 0, 0, 0]

    assert_equal expected_data, m.rationalize.data
  end

  def test_scalar_div
    m = Clifford::Multivector3DMod.new [2,3,4,5,6,7,8,9], 257

    scalar = 12

    expected_data = [43, 193, 86, 236, 129, 22, 172, 65]

    assert_equal expected_data, m.scalar_div(scalar).data
  end

  def test_scalar_mul
    m = Clifford::Multivector3DMod.new [2,3,4,5,6,7,8,9], 257

    scalar = 12

    expected_data = [24, 36, 48, 60, 72, 84, 96, 108]

    assert_equal expected_data, m.scalar_mul(scalar).data
  end

  def test_plus
    input1 = Array.new(8){ Clifford::Tools.random_number(8)}
    m1 = Clifford::Multivector3DMod.new input1, 257

    input2 = Array.new(8){ Clifford::Tools.random_number(8)}
    m2 = Clifford::Multivector3DMod.new input2, 257

    expected_data = input1.map.with_index{|a,i| (a + input2[i]) % 257}

    assert_equal expected_data, m1.plus(m2).data
  end

  def test_minus
    input1 = Array.new(8){ Clifford::Tools.random_number(8)}
    m1 = Clifford::Multivector3DMod.new input1, 257

    input2 = Array.new(8){ Clifford::Tools.random_number(8)}
    m2 = Clifford::Multivector3DMod.new input2, 257

    expected_data = input1.map.with_index{|a,i| (a - input2[i]) % 257}

    assert_equal expected_data, m1.minus(m2).data
  end

  def test_inverse
    m = nil

    while true
      input = Array.new(8){ Clifford::Tools.random_number(8)}
      m = Clifford::Multivector3DMod.new input, 257
      break if m.rationalize.data.uniq != [0]
    end

    expected_data = [1] + [0] * 7

    assert_equal expected_data, m.gp(m.inverse).data
  end

  def test_z
    input = Array.new(8){ Clifford::Tools.random_number(8)}
    m = Clifford::Multivector3DMod.new input, 257

    input[1..6] = [0] * 6

    assert_equal input, m.z.data
  end

  def test_f
    input = Array.new(8){ Clifford::Tools.random_number(8)}
    m = Clifford::Multivector3DMod.new input, 257

    input[0] = 0
    input[7] = 0

    assert_equal input, m.f.data
  end

  def test_z_plus_f
    input = Array.new(8){ Clifford::Tools.random_number(8)}
    m = Clifford::Multivector3DMod.new input, 257

    assert_equal m.data, m.z.plus(m.f).data
  end

  def test_f2
    input = Array.new(8){ Clifford::Tools.random_number(8)}
    m = Clifford::Multivector3DMod.new input, 257

    assert_equal [0] * 6, m.f2.data[1..6]
  end

end
