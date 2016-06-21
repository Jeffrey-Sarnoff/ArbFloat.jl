## ArbFloats.jl
###### Arb available as an extended precision floating point context.

```ruby
                                                         Jeffrey Sarnoff © 2016˗May˗26 in New York City
```
#####This is for Julia v0.5

####Appropriateness

Best for use where extended precision floating point values are helpful and 150 decimal digits or 500 binary digits suffice.  
Very good for use where arithemetic, elementary, and some special functions are to be evaluated and 500 decimal digits suffice.  


####Conceptual Background

Without loss of _relevant_ generality, allow that `floats` be precision parameterized floating point types which enfold only finite, fully resolved, uniquely represented, nonnegative and exponentless (significands only, no sign field, no exponent field).

#####Transparent Numeration

A `Transparent Float` is a number concept, an apperceptual framing of value from which clarity obtains as immediacy and the the qualitatively utilitarian obtains as conveyable. 

An `ArbFloat`, when viewed, looks just like an extended precision floating point value; yet when mapped through mathematical functions, transforms as an extended precision floating point interval.  Their confluence clarifys what distinguishes obtained value from calculated value.

An `ArbFloat` is a transparent value, informing while neither misleading nor leading.

####About Arb

  This work is constructed atop a state-of-the-art C library for working with _midpoint ± radius_ intervals, `Arb`.   
  `Arb` is designed and written by Fredrik Johansson, who graciously allows Julia to use it under the MIT License.  


It is a useful fiction to think of ArbFloats as Arb values with a zero radius -- and sometimes they are.  
When an ArbFloat has a nonzero radius, the user sees only those digits that _don`t care_:  
the digits which remain after rounding the ArbFloat so that the radius is subsumed (as if 0.0).


####Install
```julia
Pkg.clone("https://github.com/Jeffrey-Sarnoff/ArbFloats.jl")  # requires a recent Julia v0.5.0-dev
```

####Use
```F#
using ArbFloats

five = ArbFloat(5)
5

e = exp(ArbFloat(1))
2.7182_8182_8459_0452_3536_0287_4713_5266_2 ± 4.8148250e-35
fuzzed_e = tan(atanh(tanh(atan(e))))
2.7182_8182_8459_0452_3536_0287_4713_52662 ± 7.8836806e-33

bounds(e)
( 2.7182_8182_8459_0452_3536_0287_4713_52663,
  2.7182_8182_8459_0452_3536_0287_4713_52664 )
smartstring(e)
2.7182_8182_8459_0452_3536_0287_4713_5266₊

bounds(fuzzed_e)
( 2.7182_8182_8459_0452_3536_0287_4713_52654,
  2.7182_8182_8459_0452_3536_0287_4713_52670 )
smartstring(fuzzed_e)
2.7182_8182_8459_0452_3536_0287_4713_527₋


# Float32 and ArbFloat32
# typealias ArbFloat32 ArbFloat{24}  # predefined
setprecision(ArbFloat, 24)


fpOneThird = 1.0f0 / 3.0f0
0.3333_334f0

oneThird = ArbFloat(1) / ArbFloat(3)
0.3333_333 ± 2.9803_322e-8

# gamma(1/3) is 2.6789_3853_4707_7476_3365_5692_9409_7467_7644~

gamma_oneThird = gamma( oneThird )
2.6789_380  ± 1.8211887e-6

bounds(gamma_oneThird)
(2.6789_360, 2.6789_400)

gamma( fpOneThird )
2.6789_384f0
```

## Exports (including re-exports)

used with Arb and ArbFloat | nature
---------------------------|-------
precision, setprecision,   | as with BigFloat


Arb values are intervals | nature
--------|--------
midpoint, radius, lowerbound, upperbound, bounds,          | Arb's constituent parts  
isexact, notexact,                                         | float-y or interval-y  
overlap, donotoverlap,                                     | of interval suborder  
contains, iscontainedby, doesnotcontain, isnotcontainedby, | of interval partial order  

```
ArbFloat values: Arb seen as precisely accurate floats   
   elevates transparant information over number mumble  
   each digit shown is an accurate refinement of value  

The least significant digit observable, through show(af) or with string(af),   
  is smallest transparent _(intrisically non-misleading)_ refinement of value.
```

ArbFloat attributes | nature
--------|--------
isnan, isinf, isfinite, issubnormal, isinteger, notinteger,  | floatingpoint predicates
iszero, notzero, nonzero, isone, notone,  | number predicates
ispositive, notpositive, isnegative, notnegative,   | numerical predicates


copy, deepcopy, 
zero, one, eps, epsilon,    
isequal, isless, (==),(!=),(<),(<=),(>=),(>), notequal, approxeq, ≊,  
min, max, minmax, 

signbit, sign, flipsign, copysign, abs, inv,  
(+),(-),(*),(/),(\),(%),(^), sqrt, invsqrt, hypot,  
trunc, round, ceil, floor,   
pow, root, exp, expm1, log, log1p, log2, log10, logbase,  
sin, cos, sincos, sincospi, tan, csc, sec, cot, asin, acos, atan, atan2,  
sinh, cosh, sinhcosh, tanh, csch, sech, coth, asinh, acosh, atanh,  
factorial, doublefactorial, risingfactorial, gamma, lgamma, digamma,  
sinc, zeta, polylog, agm  
