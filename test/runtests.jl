using AlgebraOfNNs
using Test
using Random
rng = Random.Xoshiro(1234)

@testset "Integration tests" begin
    import Lux
    using Lux: Dense
    l1 = Dense(1=>2)
    l2 = Dense(1=>3)

    init(x) = Lux.setup(rng, x)
    # binary addition
    @test init(@lift_nn l1 + l2) isa Any

    # n-ary addition
    @test init(@lift_nn l1 + l2 + l1 + l2) isa Any

    # binary addition of numbers
    @test init(@lift_nn 1 + 2) isa Any

    # binary addition of variables
    x = 1
    y = 2
    @test_broken init(@lift_nn x + y) isa Any

    # basic scalar mult
    @test init(@lift_nn 2*l1) isa Any

    # complicated scalar mult
    # but please don't write formulas like this
    @test init(@lift_nn 2*2*l1) isa Any

    # basic unary
    @test init(@lift_nn -l1) isa Any

    # another unary
    @test init(@lift_nn tanh(l1)) isa Any
end
