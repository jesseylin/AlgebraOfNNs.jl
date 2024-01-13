function lift(y::Number)
    return WrappedFunction(x -> fill(y, size(x)))
end

function lift_unary(func, op)
    return quote
        Lux.Chain($op, Lux.WrappedFunction($func))
    end
end

function lift_nary(func, ops...)
    ops = [op isa Number ? lift(op) : op for op in ops]
    return quote
        Lux.Parallel($func, $(ops...))
    end
end
