module AlgebraOfNNs

export @lift_nn

using Lux: Parallel, Chain, WrappedFunction
using MacroTools: postwalk
using LuxCore: AbstractExplicitLayer

include("./operator_morphisms.jl")
include("./lift.jl")

end
