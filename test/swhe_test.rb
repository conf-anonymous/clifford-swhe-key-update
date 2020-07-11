require Dir.pwd + "/test/test_helper"

class TestSWHE< Minitest::Test

  def test_encryption_decryption
    l = 256
    m_10 = 23

    sk = Clifford::SWHE.new l
    c = sk.encrypt(m_10)

    assert_equal m_10, sk.decrypt(c)
  end

  def test_homomorphic_addition
    l = 256

    m1_10 = 16
    m2_10 = 24

    sk = Clifford::SWHE.new l
    c1 = sk.encrypt(m1_10)
    c2 = sk.encrypt(m2_10)

    assert_equal m1_10 + m2_10, sk.decrypt(sk.add(c1,c2))
  end

  def test_homomorphic_scalar_div
    l = 256

    m_10 = 33
    s = 4

    sk = Clifford::SWHE.new l
    c = sk.encrypt(m_10)

    assert_equal Rational(m_10,s), sk.decrypt(sk.sdiv(c,s))
  end

  def test_homomorphic_median
    l = 256

    m1_10 = 21
    m2_10 = 18
    m3_10 = 26
    m4_10 = 11
    m5_10 = 27

    sk = Clifford::SWHE.new l

    c1 = sk.encrypt(m1_10)
    c2 = sk.encrypt(m2_10)
    c3 = sk.encrypt(m3_10)
    c4 = sk.encrypt(m4_10)
    c5 = sk.encrypt(m5_10)

    s = 5

    expected_value = Rational(m1_10 + m2_10 + m3_10 + m4_10 + m5_10,s)

    csum = c1.plus(c2).plus(c3).plus(c4).plus(c5)

    assert_equal expected_value, sk.decrypt(sk.sdiv(csum,s))
  end
end
