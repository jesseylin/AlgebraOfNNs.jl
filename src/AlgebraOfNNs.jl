module AlgebraOfNNs

export @lift_nn

using Lux: Parallel, Chain, WrappedFunction
using MacroTools: postwalk

include("./operator_morphisms.jl")
include("./lift.jl")

end
