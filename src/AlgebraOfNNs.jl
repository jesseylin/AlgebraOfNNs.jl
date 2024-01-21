module AlgebraOfNNs

export @lift_nn

using MacroTools: postwalk
using Logging

include("./operator_morphisms.jl")
include("./lift.jl")

end
