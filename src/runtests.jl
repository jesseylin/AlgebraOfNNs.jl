l1 = Dense(3 => 2)
l2 = Dense(2 => 1)
expr = Meta.parse("2*l1+l2")
new_ex = MacroTools.postwalk(expr) do x
    if @capture(x, a_ + b_)
        return eval(:(convert_add($a, $b)))
    elseif @capture(x, a_ * b_)
        return eval(:(convert_multiply($a, $b)))
    else
        return x
    end
end
