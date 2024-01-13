# AlgebraOfNNs.jl

A simple library which allows you to do algebraic manipulations on neural
network models/layers defined in [Lux.jl](https://github.com/LuxDL/Lux.jl), for
example if `l1` and `l2` are Lux layers, then

```julia
l3 = @lift_nn 2*l1 + l2
```

defines a Lux layer `l3` such that for an input `x`, the layer produces an output
`l3(x) = 2*l1(x) + l2(x)`.

## Technical Motivation

Given two real-valued functions `f` and `g` which have the same domain, we can
define an algebra over the real numbers such that `h=f+g` defines another
real-valued function `h`. Because parameterized neural networks can be defined
as real-valued functions over the real numbers (excluding their parameters), then
we can ["lift"](<https://en.wikipedia.org/wiki/Lift_(mathematics)>) this algebra
to an algebra over neural networks.

## Basic Functionality

```julia
using AlgebraOfNNs
using Lux
l1 = Dense(16=>32)
l2 = Dense(16=>32)
l3 = @lift_nn 2*l1+l2
```

will call constructors for Lux's `Parallel` and `Chain` layers such that

```julia
julia> l3
Parallel(
    +
    Parallel(
        *
        WrappedFunction(#1),
        Dense(16 => 32),                # 544 parameters
    ),
    Dense(16 => 32),                    # 544 parameters
)         # Total: 1_088 parameters,
          #        plus 0 states.
```

## Features

- Works generically for any function call, not just algebraic operators (i.e.,
  recall that in Julia even arithmetic operations like `a+b+c` are themselves simply
  n-ary function calls `+(a,b,c)`)
- Does not introduce any new state or learnable parameters
