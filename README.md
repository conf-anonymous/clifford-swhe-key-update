# Clifford SWHE and Key Update

Ruby library for a somewhat homomorphic encryption scheme and a key update protocol based on Clifford geometric algebra.

## Requirements

This code requires Ruby installed on your system. There are [several options for downloading and installing Ruby](https://www.ruby-lang.org/en/downloads/ "Download Ruby").

This project uses only Ruby standard libraries, so once you have Ruby installed (version 2.6.3 and greater), you have everything required to run the code. We tested our implementation on Mac OSX version 10.13.6 with ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-darwin17].

## Usage

### Running tests

Once Ruby is installed on your machine, from the command line and in the root directory of the project, run the tests to check the code with the following command:

`$ rake`

You should get a result similiar to the following:

```console
Run options: --seed 9109

# Running:

...........

Finished in 5.316182s, 2.0692 runs/s, 9.0290 assertions/s.

11 runs, 48 assertions, 0 failures, 0 errors, 0 skips
```

### Ruby Interactive Shell

You can also run code from the Ruby Interactive Shell (IRB). From the project's root directory, execute the following command on the terminal:

`$ irb`

You will see the IRB's prompt. Next, command snippets for specific cases that can be executed on IRB.

### Working with multivectors and modular arithmetic

Require the file the will boot the entire project on IRB:

`> require './boot'`

In order to create a mulltivector `m` with modulus `257` (a prime number, so it is guaranteed that all numbers less then 257 has a multiplicative inverse with respect to 257), we execute:

`> m = Clifford::Multivector3DMod.new [2,3,4,5,6,7,8,9], 257`

`=> 2e0 + 3e1 + 4e2 + 5e3 + 6e12 + 7e13 + 8e23 + 9e123`

Clifford conjugation:

`> m.clifford_conjugation`

or

`> m.cc`

`=> 2e0 + 254e1 + 253e2 + 252e3 + 251e12 + 250e13 + 249e23 + 9e123`

Reverse:

`> m.reverse`

`=> 2e0 + 3e1 + 4e2 + 5e3 + 251e12 + 250e13 + 249e23 + 248e123`

Amplitude squared:

`> m.amplitude_squared`

`=> 22e0 + 0e1 + 0e2 + 0e3 + 0e12 + 0e13 + 0e23 + -16e123`

Rationalize:

`> m.rationalize`

`=> 226e0 + 0e1 + 0e2 + 0e3 + 0e12 + 0e13 + 0e23 + 0e123`

Inverse:

`> m.inverse`

`=> 111e0 + 255e1 + 222e2 + 216e3 + 40e12 + 177e13 + 115e23 + 233e123`

Geometric product:

`> m.geometric_product(m.inverse)` or `>> m.gp(m.inverse)`

`=> 1e0 + 0e1 + 0e2 + 0e3 + 0e12 + 0e13 + 0e23 + 0e123`

`> m.gp(m)`

`=> 81e0 + 125e1 + 142e2 + 169e3 + 114e12 + 213e13 + 86e23 + 88e123`

Addition:

`> m.plus(m)`

`=> 4e0 + 6e1 + 8e2 + 10e3 + 12e12 + 14e13 + 16e23 + 18e123`

Subtraction:

`> m.minus(m)`

`=> 0e0 + 0e1 + 0e2 + 0e3 + 0e12 + 0e13 + 0e23 + 0e123`

Scalar division:

`> m.scalar_div(2)`

`=> 1e0 + 130e1 + 2e2 + 131e3 + 3e12 + 132e13 + 4e23 + 133e123`

Scalar multiplication:

`> m.scalar_mul(2)`

`=> 4e0 + 6e1 + 8e2 + 10e3 + 12e12 + 14e13 + 16e23 + 18e123`

All multivectors M in Cl(3,0) can be decomposed as in M = Z + F. Obtaining Z:

`> m.z`

`=> 2e0 + 0e1 + 0e2 + 0e3 + 0e12 + 0e13 + 0e23 + 9e123`

Obtaining F:

`> m.f`

`=> 0e0 + 3e1 + 4e2 + 5e3 + 6e12 + 7e13 + 8e23 + 0e123`

Obtaining F squared:

`> m.f2`

`=> 158e0 + 0e1 + 0e2 + 0e3 + 0e12 + 0e13 + 0e23 + 52e123`

### Tools

Random number:

`> bits = 16`

`> Clifford::Tools.random_number(bits)`

`=> 33756`

Random prime:

`> Clifford::Tools.random_prime(bits)`

`=> 49499`

Next prime:

`> Clifford::Tools.next_prime(19222)`

`=> 19231`

Random input: say we want to generate a random multivector input of 16-bit coefficients

`> input = Clifford::Tools.generate_random_input(16)`

`=> [59387, 41848, 35190, 60138, 53917, 57341, 44830, 55623]`

Random multivector: say we want to generate a random multivector with 16-bit coefficints and with the modulus being the smallest next prime to 2**16:

`b = 16`

`q = Clifford::Tools.next_prime(2**b)`

`=> 65537`

`m = Clifford::Tools.generate_random_multivector_mod(b,q)`

`=> 62315e0 + 34016e1 + 33222e2 + 44867e3 + 62742e12 + 54760e13 + 41000e23 + 36601e123`

Number to multivector:

`> n = 19`

`> b = 32`

`> q = Clifford::Tools.next_prime(2**b)`

`=> 4294967311`

`g = Clifford::Tools.random_number(b)`

`=> 3333669772`

`> m = Clifford::Tools.number_to_random_multivector_mod(n,b,q,g)`

`=> 2118956385e0 + 1814335862e1 + 4291020503e2 + 601431315e3 + 1671051067e12 + 2614893202e13 + 1204384486e23 + 3207184209e123`

`> Clifford::Tools.multivector_to_number(m,b,q,g)`

`=> 19`

### SWHE Scheme

Let l (the security parameter 1^lambda) be `l = 256`.

`m1_10 = 16`

`m2_10 = 19`

`s = 4`

`sk = Clifford::SWHE.new l`

`c1 = sk.encrypt(m1_10)`

`=> 2507348350e0 + 714892089e1 + 4086593007e2 + 3029231088e3 + 3544757319e12 + 3529259721e13 + 4159126069e23 + 2329096678e123`

`c2 = sk.encrypt(m2_10)`

`=> 3573928374e0 + 712457465e1 + 441882640e2 + 764429612e3 + 2812231519e12 + 3863896228e13 + 3578512188e23 + 3157681092e123`

`> s = 2`

`> sk.decrypt(sk.add(c1,c2))`

`=> 40`

`sk.decrypt(sk.sdiv(sk.add(c1,c2),s))`

`=> 20`

### Key Update Protocol

`l = 256`

`sk1 = Clifford::SWHE.new l`

`sk2 = Clifford::SWHE.new l`

`m_10 = 18`

`c_old = sk1.encrypt(m_10)`

`=> 1563854386e0 + 2091271712e1 + 648391928e2 + 2240080558e3 + 3254051676e12 + 986877749e13 + 541981368e23 + 2807228404e123`

`c_test = sk2.encrypt(m_10)`

`=> 2046430320e0 + 1659420006e1 + 3331331529e2 + 1046982661e3 + 2654118961e12 + 3632208347e13 + 4117720672e23 + 2892896236e123`

`t = Clifford::KeyUpdate.token_generation(sk1,sk2)`

`t = Clifford::KeyUpdate.token_generation(sk1,sk2)`

`=> [3134816283e0 + 892430456e1 + 2353052136e2 + 3264834372e3 + 1576924386e12 + 4151342564e13 + 613685620e23 + 343425411e123, 1786059064e0 + 3230632592e1 + 2940301275e2 + 2364499527e3 + 1283420839e12 + 1876862914e13 + 3425636812e23 + 2295065137e123]`

`c_new = Clifford::KeyUpdate.key_update(t,c_old)`

`sk2.decrypt(c_new)`

`=> 18`
