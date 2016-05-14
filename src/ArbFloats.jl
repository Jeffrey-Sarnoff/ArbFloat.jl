module ArbFloats

import Base: hash, convert, promote_rule, isa,
    string, show, showcompact, showall, parse,
    precision, setprecision,
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
       libarb,
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

libDir=Pkg.dir("Nemo/local/lib");
libFiles = readdir(libDir);
libarb   = joinpath(libDir,libFiles[findfirst([startswith(x,"libarb") for x in libFiles])])
isfile(libarb)   || throw(ErrorException("libarb not found"));
@linux_only begin
    libarb = String(split(libarb,".so")[1])
end
@osx_only begin
    libarb = String(split(libarb,".dynlib")[1])
end
@windows_only begin
    libarb = String(split(libarb,".dll")[1])
end

macro libarb(sym)
    (:($sym), libarb)
end


NotImplemented(info::AbstractString="") = error(string("this is not implemented\n\t",info,"\n"))

include("type/ArbFloat.jl")
#=
#include("c_structs.jl")
include("retype/layGround.jl")

include("api/ArbLib.jl")
include("api/AcbLib.jl")
include("api/HypergeoLib.jl")
include("api/EllipticLib.jl")
include("api/CalculusLib.jl")

#include("retype/layGround.jl")
include("retype/ArbSpans.jl")
include("retype/ArbBoxes.jl")
include("retype/ArbPolys.jl")
include("retype/ArbMatricies.jl")
=#

end # ArbFloats
