require Dir.pwd + "/test/test_helper"

class TestSWHE< Minitest::Test

  def test_encryption_decryption
    l = 256
    m_10 = 23

    swhe = Clifford::SWHE.new l
    c = swhe.encrypt(m_10)

    assert_equal m_10, swhe.decrypt(c)
  end

  def test_homomorphic_addition
    l = 256

    m1_10 = 16
    m2_10 = 19

    swhe = Clifford::SWHE.new l
    c1 = swhe.encrypt(m1_10)
    c2 = swhe.encrypt(m2_10)

    assert_equal m1_10 + m2_10, swhe.decrypt(swhe.add(c1,c2))
  end

  def test_homomorphic_scalar_div
    l = 256

    m_10 = 32
    s = 4

    swhe = Clifford::SWHE.new l
    c = swhe.encrypt(m_10)

    assert_equal m_10 / s, swhe.decrypt(swhe.sdiv(c,s))
  end

  def test_homomorphic_median
    l = 256

    m1_10 = 21
    m2_10 = 18
    m3_10 = 26
    m4_10 = 11

    swhe = Clifford::SWHE.new l

    c1 = swhe.encrypt(m1_10)
    c2 = swhe.encrypt(m2_10)
    c3 = swhe.encrypt(m3_10)
    c4 = swhe.encrypt(m4_10)

    s = 4

    expected_value = (m1_10 + m2_10 + m3_10 + m4_10) / s

    csum = c1.plus(c2).plus(c3).plus(c4)

    assert_equal expected_value, swhe.decrypt(swhe.sdiv(csum,s))
  end
end
