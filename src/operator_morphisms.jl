function lift_number(y::Number)
    return WrappedFunction(x -> fill(y, size(x)))
end
function lift_mult(scalar::Number, op)
    return quote
        Lux.Chain($op, Lux.WrappedFunction(x -> $scalar * x))
    end
end
lift_mult(op, scalar::Number) = lift_mult(scalar, op)

function lift_nary(func, ops...)
    ops = [op isa Number ? lift_number(op) : op for op in ops]
    return quote
        Lux.Parallel($func, $(ops...))
    end
end
function lift_unary(func, op)
    return quote
        Lux.Chain($op, Lux.WrappedFunction(func))
    end
end
