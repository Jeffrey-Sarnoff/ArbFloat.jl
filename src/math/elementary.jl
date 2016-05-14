#=
    exp, expm1, log, log1p,
    sin, sinpi, cos, cospi, tan, tanpi, cot, sinh, cosh, tanh, coth
    asin, acos, atan, asinh, acosh, atanh,
    sinc,
    gamma, lgamma, zeta
=#

for (op,cfunc) in ((:exp,:arb_exp), (:expm1, :arb_expm1), (:log,:arb_log), (:log1p, :arb_log1p),
    (:sin, :arb_sin), (:sinpi, :arb_sinpi), (:cos, :arb_cos), (:cospi, :arb_cospi), 
    (:tan, :arb_tan), (:tanpi, :arb_tanpi), (:cot, :arb_cot),
    (:sinh, :arb_sinh), (:cosh, :arb_sinh), (:tanh, :arb_tanh), (:coth, :arb_coth),
    (:asin, :arb_asin), (:acos, :arb_asin), (:atan, :arb_atan),
    (:asinh, :arb_asinh), (:acosh, :arb_asinh), (:atanh, :arb_atanh),
    (:sinc, :arb_sinc),
    (:gamma, :arb_gamma), (:lgamma, :arb_lgamma), (:zeta, :arb_zeta)
    )
  @eval begin
    function ($op){P}(x::ArbFloat{P})
      z = ArbFloat{P}(0,0,0,0,0,0)
      ccall(@libarb(arb_init), Void, (Ptr{ArbFloat},), &z)
      ccall(@libarb($cfunc), Void, (Ptr{ArbFloat}, Ptr{ArbFloat}, Ptr{ArbFloat}, Int), &z, &x, P)
      finalizer(z, clearArbFloat)      
      z
    end
  end
end
