function show{P}(io::IO, x::ArbFloat{P})
    s = string(x)
    print(io, s)
end

function showall{P}(io::IO, x::ArbFloat{P})
    s = string(midpoint(x)," ± ", convert(Float64.radius(x)))
    print(io, s)
end

function showcompact{P}(io::IO, x::ArbFloat{P})
    showcompact(io, Float64(midpoint(x)))
end

function showsmart{P}(io::IO, x::ArbFloat{P})
    s = smartstring(x)
    print(io, s)
end

function showsmart{P}(x::ArbFloat{P})
    s = smartstring(x)
    print(s)
end
