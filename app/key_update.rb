module Clifford
  class KeyUpdate

    def self.token_generation(sk1,sk2)
      t1 = sk2.k1.gp(sk1.k1.inverse).scalar_div(sk1.g).scalar_mul(sk2.g)
      t2 = sk1.k2.inverse.gp(sk2.k2)
      t = [t1,t2]
    end

    def self.key_update(t,c)
      t[0].gp(c).gp(t[1])
    end

  end
end
