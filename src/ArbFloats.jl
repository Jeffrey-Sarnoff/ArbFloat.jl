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
       ArbSegment,    # midpoint ± 'radius' ('radius' is an equiprobable span, a line segment)
       ArbEllipse,    # as Complex(real ArbSegment, imaginary ArbSegment)
                      #    the real 'radius' and the imaginary 'radius' 
                      #    are as the conjugate diameters of an ellipse
                      #    positioned about the cartesian (or polar) location
                      #    given as Complex(real midpoint, imaginary midpoint)
                      #    and oriented with the real 'radius' centered along
                      #    the phase atan2( midpoint(imag), midpoint(real) )
                      #    and centered about Complex(midpoint(real), midpoint(imag))
                      #    with the imaginary 'radius' about the same center
                      #    oriented perpendicular to the real diameter 
                      #    atan2(-midpoint(imag), -midpoint(real) ).
                      #    The two perpendicular centered segments escribe a box
                      #    that bounds an ellipse -- the box necessarily bounds
                      #    the intended value, the ellipse may or may not carry
                      #    information that admits additional locative refinement.

include("api/ArbLib.jl")
include("api/AcbLib.jl")

include("type/Arb.jl")
include("type/Acb.jl")




end # ArbFloats
