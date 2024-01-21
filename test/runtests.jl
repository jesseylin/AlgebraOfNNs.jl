using AlgebraOfNNs
using Test
using Random
using Logging
# Note: must resolve Lux into top-level name-space, due to how the library
# dynamically imports Lux if it is not @isdefined already
import Lux
using Lux: Dense

rng = Random.Xoshiro(1234)
test_logger = TestLogger(; min_level=Warn)
global_logger(test_logger)

@testset "Integration tests" begin
    l1 = Dense(1 => 2)
    l2 = Dense(1 => 3)

    init_test(x) = !isnothing(Lux.setup(rng, x))
    # binary addition
    @test init_test(@lift_nn l1 + l2)

    # n-ary addition
    @test init_test(@lift_nn l1 + l2 + l1 + l2)

    # binary addition of numbers
    @test init_test(@lift_nn 1 + 2)

    # basic scalar mult
    @test init_test(@lift_nn 2 * l1)

    # complicated scalar mult
    # but please don't write formulas like this
    @test init_test(@lift_nn 2.5 * 1.5 * l1)

    # scalar mult with π
    # FIXME: I don't think this is possible to fix
    @test_broken init_test(@lift_nn π * l1)

    # basic unary
    @test init_test(@lift_nn -l1)

    # another unary
    with_logger(test_logger) do
        init_test(@lift_nn tanh(l1))
    end
    @test occursin("untested", test_logger.logs[1].message)

end
