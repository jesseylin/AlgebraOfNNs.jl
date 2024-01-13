function lift_nn(ex)
    return postwalk(ex) do x
        if Base.isexpr(x, :call)
            local func = x.args[1]
            local args = x.args[2:end]

            # Base.MainInclude.eval is used to explicitly request expression
            # substitution of the AST starting from leaves and within the macro
            # call environment
            # FIXME: Doing it this way means that the user must have
            # AlgebraOfNNs resolvable at the call site
            if !(func in [:+, :*, :/, :-])
                @warn "Expanding macro for untested value $(func). Proper behavior is not guaranteed."
            end
            if length(args) > 1
                return Base.MainInclude.eval(:(AlgebraOfNNs.lift_nary($func, $args...)))
            else
                return Base.MainInclude.eval(:(AlgebraOfNNs.lift_unary($func, $args...)))
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
