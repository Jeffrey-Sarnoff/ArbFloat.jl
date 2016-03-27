module ArbFloats

import Base: hash, convert, promote_rule, isa,
    string, show, showcompact, showall, parse,
    zero, one, ldexp, frexp, eps,
    isequal, isless, (==),(!=),(<),(<=),(>=),(>)
    min, max, minmax,
    isnan, isinf, isfinite, issubnormal,
    signbit, sign, flipsign, copysign, abs,
    (+),(-),(*),(/),(\),(%),(^),sqrt,
    trunc, round, ceil, floor,
    fld, cld, div, mod, rem, divrem, fldmod

export ArbFloat,      # co-matched decimal rounding, n | round(hi,n,10) == round(lo,n,10)
       ArbSpan,       # midpoint ± 'radius' ('radius' is an equiprobable span, a line segment)
       ArbBox,        # as Complex(real ArbSegment, imaginary ArbSegment)
       ArbPoly,       # polynomials with Real Arb coeffs or Complex Arb [Acb] coeffs
       ArbMatrix      # matricies with Real Arb or Complex Arb [Acb] constituents 

       
                      # Complex( ArbSpan(real), ArbSpan(imaginary) )
                      #
                      #    The real 'radius' and the imaginary 'radius' form a bounding box
                      #    in the complex plane centered on the place indicated as
                      #    Complex( midpoint(real), midpoint(imaginary) ) and oriented
                      #    by considering the 'radii' as conjugate diameters of an ellipse
                      #    < this ellipse gives the box as that in which it is inscribed >
                      #    positioned about the cartesian (or polar) location
                      #    given as Complex(real midpoint, imaginary midpoint)
                      #    and oriented with the real 'radius' centered along
                      #    the phase atan2( midpoint(imag), midpoint(real) )
                      #    and centered about Complex(midpoint(real), midpoint(imag))
                      #    with the imaginary 'radius' about the same center
                      #    oriented perpendicular to the real diameter 
                      #    atan2(-midpoint(imag), -midpoint(real) ).
                      

include("api/ArbLib.jl")
include("api/AcbLib.jl")
include("api/HypergeoLib.jl")
include("api/EllipticLib.jl")
include("api/CalculusLib.jl")

include("retype/ArbSpan.jl")
include("retype/ArbBox.jl")
include("retype/ArbPoly.jl")
include("retype/ArbMatrix.jl")

include("type/ArbFloat.jl")




end # ArbFloats