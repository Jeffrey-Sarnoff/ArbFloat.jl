
log2o10{P}(::Type{ArbFloat{P}}) = log(ArbFloat{P}(2))/log(ArbFloat{P}(10))
log10o2{P}(::Type{ArbFloat{P}}) = log(ArbFloat{P}(10))/log(ArbFloat{P}(2))

exp1{P}(::Type{ArbFloat{P}})    = exp(ArbFloat{P}(1))

fourpi{P}(::Type{ArbFloat{P}})  = ArbFloat{P}(16)*atan(ArbFloat{P}(1))
twopi{P}(::Type{ArbFloat{P}})   = ArbFloat{P}(8)*atan(ArbFloat{P}(1))
onepi{P}(::Type{ArbFloat{P}})   = ArbFloat{P}(4)*atan(ArbFloat{P}(1))
halfpi{P}(::Type{ArbFloat{P}})  = ArbFloat{P}(2)*atan(ArbFloat{P}(1))
qrtrpi{P}(::Type{ArbFloat{P}})  = atan(ArbFloat{P}(1))


golden{P}(::Type{ArbFloat{P}})  = (1+sqrt(ArbFloat{P}(4)))/ArbFloat{P}(2)

