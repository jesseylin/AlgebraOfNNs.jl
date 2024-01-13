function lift_nn(ex)
    return postwalk(ex) do x
        if Base.isexpr(x, :call)
            local func = x.args[1]
            local args = x.args[2:end]
            if func in [:+, :-, :*, :/]
                # Base.MainInclude.eval is used to explicitly request expression
                # substitution of the AST starting from leaves
                return Base.MainInclude.eval(:(AlgebraOfNNs.lift_nary($func, $args...)))
            end
        else
            return x
        end
    end
end

macro lift_nn(ex)
    # escape in order to use the scope of the call site
    return esc(lift_nn(ex))
end
