require Dir.pwd + "/test/test_helper"

class TestTools < Minitest::Test

  # def test_number_to_multivector
  #   b = 32
  #   n1 = 15
  #
  #   m1 = Clifford::Tools.number_to_multivector(n1,b)
  #
  #   assert_equal [15,0,0,0,0,0,0,0], m1.data
  #
  #   n2 = 91229814210228547737819239051298301041489611280280106367957638495992064363341
  #
  #   m2 = Clifford::Tools.number_to_multivector(n2,b)
  #
  #   m2_expected_data = [532007757, 630006562, 3904368407, 3185178372, 3090332575, 3205617420, 4065205764, 3383901879]
  #
  #   assert_equal m2_expected_data, m2.data
  #
  #   m2_gp_m2 = m2.gp(m2)
  #
  #   assert_equal [true], m2_gp_m2.data.map{|d| d.bit_length > b}.uniq
  # end
  #
  # def test_number_to_multivector_mod
  #   b = 32
  #   n = 98639810706146844964195056706462494573739209093239791894499446326317757763634
  #   q = 2**b
  #
  #   m = Clifford::Tools.number_to_multivector_mod(n,b,q)
  #   m_expected_data = [3783790642, 3796816038, 1987894929, 4289077962, 1388563541, 1871366190, 3173243622, 3658753925]
  #
  #   assert_equal m_expected_data, m.data
  #
  #   m_gp_m = m.gp(m)
  #
  #   assert_equal [true], m_gp_m.data.map{|d| d.bit_length <= b}.uniq
  # end
  #
  # def test_string_to_multivector
  #   b = 32
  #   s = "Clifford"
  #   n = 4858373986552083044
  #   m = Clifford::Tools.string_to_multivector(s,b)
  #
  #   m_expected_data = [1718579812, 1131178342, 0, 0, 0, 0, 0, 0]
  #
  #   assert_equal m_expected_data, m.data
  #
  #   m_gp_m = m.gp(m)
  #
  #   assert_equal [true], m_gp_m.data[0..1].map{|d| d.bit_length > b}.uniq
  # end
  #
  # def test_string_to_multivector
  #   b = 32
  #   q = 2**b
  #   s = "Clifford Mod"
  #   n = 20866557383978340475198074724
  #   m = Clifford::Tools.string_to_multivector_mod(s,b,q)
  #
  #   m_expected_data = [541945700, 1718579812, 1131178342, 0, 0, 0, 0, 0]
  #
  #   assert_equal m_expected_data, m.data
  #
  #   m_gp_m = m.gp(m)
  #
  #   assert_equal [true], m_gp_m.data[0..1].map{|d| d.bit_length <= b}.uniq
  # end
  #
  # def test_random_multivector
  #   b = 32
  #   m = Clifford::Tools.generate_random_multivector(b)
  #
  #   assert_equal [32], m.data.map{|d| d.bit_length}.uniq
  #
  #   m_gp_m = m.gp(m)
  #
  #   assert_equal [true], m_gp_m.data.map{|d| d.bit_length > b}.uniq
  # end
  #
  # def test_random_multivector_mod
  #   b = 32
  #   q = 2**b
  #   m = Clifford::Tools.generate_random_multivector_mod(b,q)
  #
  #   assert_equal [32], m.data.map{|d| d.bit_length}.uniq
  #
  #   m_gp_m = m.gp(m)
  #
  #   assert_equal [true], m_gp_m.data.map{|d| d.bit_length <= b}.uniq
  # end
  #
  # def test_random_multivector_mod
  #   b = 32
  #   q = 2**b
  #   m = Clifford::Tools.generate_random_multivector_mod_ni(b,q)
  #
  #   assert_equal [0], m.rationalize.data.uniq
  # end

end
