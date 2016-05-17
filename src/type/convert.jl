function convert{R<:Real}(::Type{ArbFloat}, x::R)
    p = precision(ArbFloat)
    convert(ArbFloat{p}, x)
end    

function convert{P}(::Type{ArbFloat{P}}, x::UInt)
    z = initializer(ArbFloat{P})
    ccall(@libarb(arb_set_ui), Void, (Ptr{ArbFloat{P}}, UInt), &z, x)
    z
end
if sizeof(Int)==sizeof(Int64)
   convert{P}(::Type{ArbFloat{P}}, x::UInt32) = convert(ArbFloat{P}, convert(UInt64,x))
else
   convert{P}(::Type{ArbFloat{P}}, x::UInt64) = convert(ArbFloat{P}, convert(UInt32,x))
end
convert{P}(::Type{ArbFloat{P}}, x::UInt16) = convert(ArbFloat{P}, convert(UInt,x))

function convert{P}(::Type{ArbFloat{P}}, x::Int)
    z = initializer(ArbFloat{P})
    ccall(@libarb(arb_set_si), Void, (Ptr{ArbFloat{P}}, Int), &z, x)
    z
end
if sizeof(Int)==sizeof(Int64)
   convert{P}(::Type{ArbFloat{P}}, x::Int32) = convert(ArbFloat{P}, convert(Int64,x))
else
   convert{P}(::Type{ArbFloat{P}}, x::Int64) = convert(ArbFloat{P}, convert(Int32,x))
end
convert{P}(::Type{ArbFloat{P}}, x::Int16) = convert(ArbFloat{P}, convert(Int,x))


function convert{P}(::Type{ArbFloat{P}}, x::Float64)
    z = initializer(ArbFloat{P})
    ccall(@libarb(arb_set_d), Void, (Ptr{ArbFloat{P}}, Float64), &z, x)
    z
end
convert{P}(::Type{ArbFloat{P}}, x::Float32) = convert(ArbFloat{P}, convert(Float64,x))
convert{P}(::Type{ArbFloat{P}}, x::Float16) = convert(ArbFloat{P}, convert(Float64,x))


function convert{P}(::Type{ArbFloat{P}}, x::String)
    b = bytestring(x)
    z = initializer(ArbFloat{P})
    ccall(@libarb(arb_set_str), Void, (Ptr{ArbFloat}, Ptr{UInt8}, Int), &z, b, P)
    z
end


convert(::Type{BigInt}, x::String) = parse(BigInt,x)
convert(::Type{BigFloat}, x::String) = parse(BigFloat,x)

convert{P}(::Type{ArbFloat{P}}, x::BigFloat) = convert(ArbFloat{P}, string(x))
convert{P}(::Type{ArbFloat{P}}, x::BigInt)   = convert(ArbFloat{P}, convert(BigFloat,x))
convert{P}(::Type{ArbFloat{P}}, x::Rational) = convert(ArbFloat{P}, convert(BigFloat,x))
convert{P,S}(::Type{ArbFloat{P}}, x::Irrational{S}) = convert(ArbFloat{P}, convert(BigFloat,x))

function convert{P}(::Type{ArbFloat{P}}, x::BigFloat)
     convert(ArbFloat{P}, string(round(x,2,P)))
end

#= returns 256.0 for convert(big(1.5))
function convert{P}(::Type{ArbFloat{P}}, x::BigFloat)
    z = initializer(ArbFloat{P})
    ccall(@libarb(arb_set_round_fmpz), Void, (Ptr{ArbFloat}, Ptr{BigFloat}, Int), &z, &x, P)
    z
end
=#

function num2str{P}(x::ArbFloat{P}, n::Int)
   flags = UInt(2)
   cstr = ccall(@libarb(arb_get_str), Ptr{UInt8}, (Ptr{ArbFloat}, Int, UInt), &x, n, flags)
   s = bytestring(cstr)
   ccall(@libflint(flint_free), Void, (Ptr{UInt8},), cstr)
   s
end

function convert{P}(::Type{Float64}, x::ArbFloat{P})
    s = num2str(x,22)
    parse(Float64,s)
    #ccall(@libarb(arb_set_d), Void, (Ptr{ArbFloat{P}}, Float64), &x, z)
    #z
end
convert{P}(::Type{Float32}, x::ArbFloat{P}) = convert(Float32,convert(Float64,x))

function convert{P}(::Type{Int}, x::ArbFloat{P})
    s = num2str(x,22)
    trunc(Int,parse(Float64,s))
    #ccall(@libarb(arb_set_si), Void, (Ptr{ArbFloat{P}}, Int), &x, z)
    #z
end
if sizeof(Int)==sizeof(Int64)
    convert{P}(::Type{Int32}, x::ArbFloat{P}) = convert(Int32,convert(Int64,x))
else
    convert{P}(::Type{Int64}, x::ArbFloat{P}) = convert(Int64,convert(Int32,x))
end

ArbFloatHalf = Dict{Int,ArbFloat}(  120 => convert(ArbFloat{120},0.5),
                                    #122 => convert(ArbFloat{122},0.5),
                                    #125 => ArbFloat{125}(0.5),
                                    #128 => ArbFloat{128}(0.5),
                                    #160 => ArbFloat{160}(0.5),
                                    #185 => ArbFloat{185}(0.5),
                                    #192 => ArbFloat{192}(0.5),
                                    #250 => ArbFloat{250}(0.5),
                                    );
                                    