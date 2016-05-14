type ArbFloat{Precision}  <: Real
  mid_exp::Int # fmpz
  mid_size::UInt # mp_size_t
  mid_d1::Int # mantissa_struct
  mid_d2::Int
  rad_exp::Int # fmpz
  rad_man::UInt
end

ArbFloatPrecision = 120
function setprecision(::Type{ArbFloat}, x::Int)
    ArbFloatPrecision = abs(x)
end
precision(::Type{ArbFloat}) = ArbFloatPrecision
precision{Precision}(x::ArbFloat{Precision}) = Precision


function clearArbFloat(x::ArbFloat)
     ccall(@libarb(arb_clear), Void, (Ptr{ArbFloat},), &x)
end

function finalizer(x::ArbFloat)
    finalizer(x, clearArbFloat)
end    

function ArbFloat()
    p = precision(ArbFloat)
    z = ArbFloat{p}(0,0,0,0,0,0)
    ccall(@libarb(arb_init), Void, (Ptr{ArbFloat},), &z)
    finalizer(z, clearArbFloat)
    z
end

function ArbFloat(x::UInt)
    p = precision(ArbFloat)
    z = ArbFloat{p}(0,0,0,0,0,0)
    ccall(@libarb(arb_init), Void, (Ptr{ArbFloat},), &z)
    ccall(@libarb(arb_set_ui), Void, (Ptr{ArbFloat}, UInt), &z, x)
    finalizer(z, clearArbFloat)
    z
end

function ArbFloat(x::Int)
    p = precision(ArbFloat)
    z = ArbFloat{p}(0,0,0,0,0,0)
    ccall(@libarb(arb_init), Void, (Ptr{ArbFloat},), &z)
    ccall(@libarb(arb_set_si), Void, (Ptr{ArbFloat}, Int), &z, x)
    finalizer(z)
    z
end

function ArbFloat(x::Float64)
    p = precision(ArbFloat)
    z = ArbFloat{p}(0,0,0,0,0,0)
    ccall(@libarb(arb_init), Void, (Ptr{ArbFloat},), &z)
    ccall(@libarb(arb_set_d), Void, (Ptr{ArbFloat}, Float64), &z, x)
    finalizer(z)
    z
end

function ArbFloat(x::BigFloat)
    p = precision(ArbFloat)
    z = ArbFloat{p}(0,0,0,0,0,0)
    ccall(@libarb(arb_init), Void, (Ptr{ArbFloat},), &z)
    ccall(@libarb(arb_set_round_fmpz), Void, (Ptr{ArbFloat}, BigFloat, Int), &z, x, p)
    finalizer(z, clearArbFloat)
    z
end


function ArbFloat(x::String)
    p = precision(ArbFloat)
    b = bytestring(x)
    z = ArbFloat{p}(0,0,0,0,0,0)
    ccall(@libarb(arb_init), Void, (Ptr{ArbFloat},), &z)
    ccall(@libarb(arb_set_str), Void, (Ptr{ArbFloat}, Ptr{UInt8}, Int), &z, b, p)
    finalizer(z, clearArbFloat)
    z
end

ArbFloat{T<:Real}(x::T) = ArbFloat(convert(BigFloat,x))


function String{P}(x::ArbFloat{P}, flags::UInt)
   n = floor(Int, P*0.3010299956639811952137)
   cstr = ccall(@libarb(arb_get_str), Ptr{UInt8}, (Ptr{ArbFloat}, Int, UInt), &x, n, flags)
   s = bytestring(cstr)
   ccall(@libflint(flint_free), Void, (Ptr{UInt8},), cstr)
   s
end

function string(x::ArbFloat)
   String(x,UInt(2)) # midpoint only, RoundNearest
end

function copy{P}(x::ArbFloat{P})
    z = ArbFloat{P}(0,0,0,0,0,0)
    ccall(@libarb(arb_init), Void, (Ptr{ArbFloat},), &z)
    ccall(@libarb(arb_set), Void, (Ptr{ArbFloat}, Ptr{ArbFloat}), &z, &x)
    finalizer(z, clearArbFloat)
    z
end

function deepcopy{P}(x::ArbFloat{P})
    z = ArbFloat{P}(0,0,0,0,0,0)
    ccall(@libarb(arb_init), Void, (Ptr{ArbFloat},), &z)
    ccall(@libarb(arb_set), Void, (Ptr{ArbFloat}, Ptr{ArbFloat}), &z, &x)
    finalizer(z, clearArbFloat)
    z
end

function midpoint{P}(x::ArbFloat{P})
    z = ArbFloat{P}(0,0,0,0,0,0)
    ccall(@libarb(arb_init), Void, (Ptr{ArbFloat},), &z)
    ccall(@libarb(arb_get_mid_arb), Void, (Ptr{ArbFloat}, Ptr{ArbFloat}), &z, &x)
    finalizer(z, clearArbFloat)
    z
end

function radius{P}(x::ArbFloat{P})
    z = ArbFloat{P}(0,0,0,0,0,0)
    ccall(@libarb(arb_init), Void, (Ptr{ArbFloat},), &z)
    ccall(@libarb(arb_get_rad_arb), Void, (Ptr{ArbFloat}, Ptr{ArbFloat}), &z, &x)
    finalizer(z, clearArbFloat)
    z
end

function upperbound{P}(x::ArbFloat{P})
    midpoint(x) + radius(x)
end
function lowerbound{P}(x::ArbFloat{P})
    midpoint(x) - radius(x)
end
function minmax{P}(x::ArbFloat{P})
   m = midpoint(x)
   r = radius(x)
   m-r, m+r
end

   
