type ArbFloat{Precision}  <: Real
  mid_exp::Int # fmpz
  mid_size::UInt # mp_size_t
  mid_d1::Int # mantissa_struct
  mid_d2::Int
  rad_exp::Int # fmpz
  rad_man::UInt
end

Base.setprecision(ArbFloat,120)

function clearArbFloat(x::ArbFloat)
     ccall((:arb_clear, :libarb), Void, (Ptr(ArbFloat),), &x)
end

function ArbFloat()
    z = ArbFloat{precision(ArbFloat)}(0,0,0,0,0,0)
    ccall((:arb_init, :libarb), Void, (Ptr{ArbFloat},), &z)
    finalizer(z, clearArbFloat)
    z
end

function ArbFloat(x::UInt)
    z = ArbFloat{precision(ArbFloat)}(0,0,0,0,0,0)
    ccall((:arb_init, :libarb), Void, (Ptr{ArbFloat},), &z)
    ccall((:arb_set_ui, :libarb), Void, (Ptr{ArbFloat}, UInt), &z, x)
    finalizer(z, clearArbFloat)
    z
end

function ArbFloat(x::Float64)
    z = ArbFloat{precision(ArbFloat)}(0,0,0,0,0,0)
    ccall((:arb_init, :libarb), Void, (Ptr{ArbFloat},), &z)
    ccall((:arb_set_d, :libarb), Void, (Ptr{ArbFloat}, Float64), &z, x)
    finalizer(z, clearArbFloat)
    z
end

function ArbFloat(x::BigFloat)
    z = ArbFloat{precision(ArbFloat)}(0,0,0,0,0,0)
    ccall((:arb_init, :libarb), Void, (Ptr{ArbFloat},), &z)
    ccall((:arb_set_fmpz, :libarb), Void, (Ptr{ArbFloat}, BigFloat), &z, x)
    finalizer(z, clearArbFloat)
    z
end



function ArbFloat(x::Int, sigbits::Int)
    z = ArbFloat{sigbits}(0,0,0,0,0,0)
    ccall((:arb_init, :libarb), Void, (Ptr{ArbFloat},), &z)
    ccall((:arb_set_si, :libarb), Void, (Ptr{ArbFloat}, Int), &z, x)
    finalizer(z, clearArbFloat)
    z
end


