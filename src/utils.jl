"currently unused"
function macro_inversion(expr, outer_sym, inner_sym)
    # checks outer expr for a macro call of outer_sym
    # then enters into the inner expr (at index 3, bc index 2 is a LineNumberNode)
    # and does an analogous check
    is_nested(x) = Base.isexpr(x, :macrocall) &&
                   x.args[1] == outer_sym &&
                   Base.isexpr(x.args[3], :macrocall) &&
                   x.args[3].args[1] == inner_sym
    prewalk(expr) do x
        if is_nested(x)
            @debug("found inner")
            # create a new expression with the outer and inner macro calls swapped
            new_ex = deepcopy(x)
            new_ex.args[1] = x.args[3].args[1]
            new_ex.args[3].args[1] = x.args[1]
            return new_ex
        else
            return x
        end
    end
end
