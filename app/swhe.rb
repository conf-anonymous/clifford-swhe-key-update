module Clifford
  class SWHE

    attr_accessor :l, :b, :q, :k1, :k2, :g

    def initialize(l)
      @l = l
      @b = l/8
      @q = Tools.next_prime(2**@b)

      k1_10 = Tools.random_number(@l)
      k2_10 = Tools.random_number(@l)

      @k1 = Tools.generate_random_multivector_mod(@b,@q)
      @k2 = Tools.generate_random_multivector_mod(@b,@q)

      @g = Tools.random_number(@b)
    end

    def encrypt(m_10)
      m = Tools.number_to_random_multivector_mod(m_10,b,q,g)
      k1.gp(m).gp(k2)
    end

    def decrypt(c)
      m = k1.inverse.gp(c).gp(k2.inverse)
      m_10 = Tools.multivector_to_number(m,b,q,g) % q
      Tools.eea(q,m_10)
    end

    def add(c1,c2)
      c1.plus(c2)
    end

    def sdiv(c1,s)
      c1.scalar_div(s)
    end

  end
end
