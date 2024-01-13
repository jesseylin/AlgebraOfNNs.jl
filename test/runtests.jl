using AlgebraOfNNs
using Test
using Random
using Logging

rng = Random.Xoshiro(1234)
test_logger = TestLogger(; min_level=Warn)
global_logger(test_logger)

@testset "Integration tests" begin
    import Lux
    using Lux: Dense
    l1 = Dense(1 => 2)
    l2 = Dense(1 => 3)

    init(x) = Lux.setup(rng, x)
    # binary addition
    @test init(@lift_nn l1 + l2) isa Any

    # n-ary addition
    @test init(@lift_nn l1 + l2 + l1 + l2) isa Any

    # binary addition of numbers
    @test init(@lift_nn 1 + 2) isa Any

    # basic scalar mult
    @test init(@lift_nn 2 * l1) isa Any

    # complicated scalar mult
    # but please don't write formulas like this
    @test init(@lift_nn 2 * 2 * l1) isa Any

    # basic unary
    @test init(@lift_nn -l1) isa Any

    # another unary
    with_logger(test_logger) do
        init(@lift_nn tanh(l1))
    end
    @test occursin("untested", test_logger.logs[1].message)

end
