module ArbFloats

import Base: hash, convert, promote_rule, isa,
    string, show, showcompact, showall, parse,
    zero, one, ldexp, frexp, eps,
    precision, setprecision,
    isequal, isless, (==),(!=),(<),(<=),(>=),(>)
    min, max, minmax,
    isnan, isinf, isfinite, issubnormal,
    signbit, sign, flipsign, copysign, abs,
    (+),(-),(*),(/),(\),(%),(^),sqrt,
    trunc, round, ceil, floor,
    fld, cld, div, mod, rem, divrem, fldmod,
    BigInt, BigFloat,
    Ptr, Ref, Csize_t, Cssize_t,
    Cdouble, Culonglong, Clonglong, Cuint, Cint, Cushort, Cshort


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
                      


# ensure the requisite libraries are available

isdir(Pkg.dir("Nemo")) || throw(ErrorException("Nemo not found"))

@linux_only begin
  libarb  = Pkg.dir("Nemo/local/lib/libarb.so")
  libflint = Pkg.dir("Nemo/local/lib/libflint.so")
  libgmp  = Pkg.dir("Nemo/local/lib/libgmp.so")
  libmpir = Pkg.dir("Nemo/local/lib/libmpir.so")
  libmpfr = Pkg.dir("Nemo/local/lib/libmpfr.so")
end

@osx_only begin
  libarb = Pkg.dir("Nemo/local/lib/libarb.dynlib")
  libflint = Pkg.dir("Nemo/local/lib/libflint.dynlib")
  libgmp  = Pkg.dir("Nemo/local/lib/libgmp.dynlib")
  libmpir = Pkg.dir("Nemo/local/lib/libmpir.dynlib")
  libmpfr = Pkg.dir("Nemo/local/lib/libmpfr.dynlib")
end

@windows_only begin
  libarb = Pkg.dir("Nemo/local/lib/libarb.dll")
  libflint = Pkg.dir("Nemo/local/lib/libflint.dll")
  libgmp  = Pkg.dir("Nemo/local/lib/libgmp.dll")
  libmpir = Pkg.dir("Nemo/local/lib/libmpir.dll")
  libmpfr = Pkg.dir("Nemo/local/lib/libmpfr.dll")
end

if isfile(libmpir) && !isfile(libgmp)
   libgmp = libmpir
end

isfile(libarb)   || throw(ErrorException("libarb not found"))
isfile(libflint) || throw(ErrorException("libflint not found"))
isfile(libgmp)   || throw(ErrorException("libgmp not found"))
isfile(libmpfr)  || throw(ErrorException("libmpfr not found"))


NotImplemented(info::AbstractString="") = error(string("this is not implemented\n\t",info,"\n"))


#include("c_structs.jl")
include("retype/layGround.jl")

include("api/ArbLib.jl")
include("api/AcbLib.jl")
include("api/HypergeoLib.jl")
include("api/EllipticLib.jl")
include("api/CalculusLib.jl")

#include("retype/layGround.jl")
#=
include("retype/ArbSpans.jl")
include("retype/ArbBoxes.jl")
include("retype/ArbPolys.jl")
include("retype/ArbMatricies.jl")
=#

#include("type/cArbLib.jl")
#include("type/ArbFloat.jl")




end # ArbFloats
