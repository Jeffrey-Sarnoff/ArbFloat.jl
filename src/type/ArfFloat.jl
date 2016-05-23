
            # P is the precision used for this value
type ArfFloat{P}  <: Real
  mid_exp::Int # fmpz
  mid_size::UInt # mp_size_t
  mid_d1::Int # mantissa_struct
  mid_d2::Int
end

precision{P}(x::ArfFloat{P}) = P

# get and set working precision for ArbFloat

const ArbFloatPrecision = [116,]
precision(::Type{ArfFloat}) = ArbFloatPrecision[1]

setprecision(::Type{ArfFloat}, x::Int) = setprecision(ArbFloat, x)

# a type specific hash function helps the type to 'just work'
const hash_arffloat_lo = (UInt === UInt64) ? 0x37e642589da3416a : 0x5d46a6b4
const hash_0_arffloat_lo = hash(zero(UInt), hash_arffloat_lo)
hash{P}(z::ArfFloat{P}, h::UInt) = 
    hash(reinterpret(UInt,z.mid_d1)$z.mid_exp, 
         (h $ hash(reinterpret(UInt,z.mid_d2)$(~reinterpret(UInt,P)), hash_arffloat_lo) $ hash_0_arffloat_lo))


function clearArfFloat{P}(x::ArfFloat{P})
     ccall(@libarb(arf_clear), Void, (Ptr{ArfFloat{P}},), &x)
end

function initializer{P}(::Type{ArbFloat{P}})
    z = ArfFloat{P}(0,0,0,0)
    ccall(@libarb(arf_init), Void, (Ptr{ArfFloat{P}},), &z)
    finalizer(z, clearArfFloat)
    z
end


midpoint{P}(x::ArfFloat{P}) = x

radius{P}(x::ArfFloat{P}) = zero(ArfFloat{P})
