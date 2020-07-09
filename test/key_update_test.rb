require Dir.pwd + "/test/test_helper"

class TestKeyUpdate < Minitest::Test

  def test_key_update
    l = 256

    sk1 = Clifford::SWHE.new l
    sk2 = Clifford::SWHE.new l

    m_10 = 18

    c_old = sk1.encrypt(m_10)
    c_test = sk2.encrypt(m_10)

    t = Clifford::KeyUpdate.token_generation(sk1,sk2)
    c_new = Clifford::KeyUpdate.key_update(t,c_old)

    assert_equal m_10, sk2.decrypt(c_new)
  end

end
