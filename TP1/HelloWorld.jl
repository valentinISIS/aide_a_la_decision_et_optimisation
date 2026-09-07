println("Hello World")

# C = 20
# (C * 9/5)+32

# (100-32)*5/9

my_answer = 42
typeof(my_answer)

my_pi = 3.14159
typeof(my_pi)

🎅 = "Santa"
typeof(🎅)

😸 = 1
typeof(😸)

😄 = 2
#Toto
😄+😸

my_sum = 3 + 7
my_difference = 10 - 3
my_product = 20 * 5
my_quotient = 100 / 10
my_power = 10 ^ 2
my_modulus = 101 % 2

days = 365
days_float = convert(Float64, days)

@assert days == 365
@assert days_float == 365.0

convert(Int64, "1")
parse(Int64, "1")

s1 = "I am a string."
s2 = """ I am also a "string" """
s3 = " But also \"me\" "

typeof('a')
name = "Jane"
num_fingers = 10
num_toes = 10

println("Hello, my name is $name")
println("I have $num_fingers fingers and $num_toes.
  That is $(num_fingers + num_toes) in all !!")

string("How many cats ", "are too many cats?")
string("I don't know, but ", 10, " are too few.")
s3 = "How many cats ";
s4 = "are too many cats?";
s3*s4
"$s3$s4"

myphonebook = Dict("Jenny" => "867-5309", "Ghostbusters" => "555-2368")
myphonebook["Kramer"] = "555-FILK"

myphonebook

pop!(myphonebook, "Kramer")
myphonebook

myphonebook[1]

myfavoriteanimals = ("penguins","cats","sugargliders")
myfavoriteanimals[1]

myfavoriteanimals[1] = "otters"

myfriends = ["Ted", "Robyn", "barney", "Lily", "Marshall"]

fibonnaci = [1, 1, 2, 3, 5, 8, 13]
mix = [1, 2, 3.0, "hi"]

myfriends[3]

myfriends[3] = "Baby Bop"
myfriends

push!(fibonnaci, 21)
pop!(fibonnaci)
fibonnaci

favorites = [["koobideh", "chocolate", "eggs"],["penguins", "cats", "sugargliders"]]

numbers = [[1, 2, 3], [4, 5], [6, 7, 8, 9]]

rand(4, 3)

rand(4, 3, 2)

fibonnaci
somenumbers = fibonnaci
somenumbers[1] = 404

fibonnaci
#also gets upated (warning)

fibonnaci[1] = 1
fibonnaci

somemorenumbers = copy(fibonnaci)

somemorenumbers
fibonnaci


a_ray = [1, 2, 3]
push!(a_ray, 4)
pop!(a_ray)
@assert a_ray == [1, 2, 3]

myphonebook
myphonebook["Emergency"] = 911
#does not work because wrong value type

flexible_phonebook = Dict("Jenny" => 8675309, "Ghostbusters" => "555-2368")
@assert flexible_phonebook == Dict("Jenny" => 8675309, "Ghostbusters" => "555-2368")

flexible_phonebook["Emergency"] = 911
@assert haskey(flexible_phonebook, "Emergency")
@assert flexible_phonebook["Emergency"] == 911

# Why can we add an integer as a value to flexible_phonebook but not myphonebook? How could we have initialized myphonebook so that it would accept integers as values?
# phonebook has a more restricted value type "String", we could have initialized it with the flexible Any type:
phonebook2 = Dict{String, Any}()
phonebook2["Emergency"] = 911
# don't forget parentheses

n = 0
while n < 10
    n += 1
    println(n)
end

myfriends = ["Ted", "Robyn", "Barney", "Lily", "Marshall"]

i = 1
while i <= length(myfriends)
    friend = myfriends[i]
    println("Hi $friend, it's great to see you!")
    i += 1
end

for n in 1:10
    println(n)
end

m, n = 5, 5
A = zeros(m, n)

for i in 1:m
   for j in 1:n
        A[i,j] = i + j
   end     
end
A

B = zeros(m, n)
for i in 1:m, j in 1:n
    B[i, j] = i + j
end
B

C = [i + j for i in 1:m, j in 1:n]

for n in 1:10
    A = [i + j for i in 1:n, j in 1:n]
    display(A)
end

x=3
y=90
if x > y
    println("$x is larger than $y")
elseif y > x
    println("$y is larger than $x")
else
    println("$x and $y are equal!")
end

if x > y
    x
else
    y
end

x > y ? x : y

(x > y) && println("$x is larger than $y")
(x < y) && println("$x is smaller than $y")

function sayhi(name)
    println("Hi $name, it's great to see you!")
end

sayhi("Adrien")

function f(x)
    x^2
end

f(4)

sayhi2(name) = println("Hi $name, its great to see you!")
sayhi2("Thérèse")

f2(x) = x^2
f2(107)

sayhi3 = name -> println("Hi $name, it's great to see you!")
f3 = x -> x^2
sayhi3("Chewbacca")
f3(89)

#Duck-typing
sayhi(970687)
A = rand(3,3)
f(A)

v = rand(3)
f(v)

v = [3, 5, 2]
sort(v)

# mutating (!) vs non mutating

v = [3, 5, 2]
sort(v)
v

sort!(v)
v

# broadcasting (.)
A = [i + 3*j for j in 0:2, i in 1:3]
f(A)

B = f.(A)
B

v = [1, 2, 3]
f.(v)

#Packages

using Pkg
Pkg.add("Example")

using Example

hello("it's me")

Pkg.add("Colors")
using Colors

Pkg.add("Plots")
using Plots

x = -3:0.1:3
f(x) = x^2
y = f.(x)

gr()

plot(x, y, label ="line")
scatter!(x, y, label="points")
# ! to affect current plot

Pkg.add("PlotlyJS")
using PlotlyJS

plotlyjs()

plot(x, y, label ="line")
scatter!(x, y, label="points")

globaltemperatures = [14.4, 14.5, 14.8, 15.2, 15.5, 15.8]
numpirates = [45000, 20000, 15000, 5000, 400, 17]

# First, plot the data
plot(numpirates, globaltemperatures, legend=false)
scatter!(numpirates, globaltemperatures, legend=false)

#This reverses x axix we can see how the temperature changes as the number of pirates increases
xflip!()

# Add titles and labels
xlabel!("Number of Pirates [Approximates]")
ylabel!("Global Temperature (C)")
title!("Influence of pirate population  on global warming")

p1 = plot(x, x)
p2 = plot(x, x.^2)
p3 = plot(x, x.^3)
p4 = plot(x, x.^4)
plot(p1,p2,p3,p4,layout=(2,2),legend=false)

# Multiple dispatch
methods(+)

@which 3 + 3
@which 3.0 + 3.0
@which 3 + 3.0

import Base: +
"hello" + "world"
@which "hello" + "world"
+(x::String, y::String) = string(x,y)
@which "hello"+"world"

foo(x,y) = println("duck-typed foo!")
foo(x::Int, y::Float64) = println("foo with an integer and a float!")
foo(x::Float64, y::Float64) = println("foo with two floats!")
foo(x::Int, y::Int) = println("foo with two integers!")

foo(1, 1)
foo(1., 1.)
foo(1, 1.0)
foo(1.0, 1.0)
foo("a",3)
foo(true,false)

#structs

struct MyObj
    field1
    field2
end

myobj1 = MyObj("Hello", "World")

myobj1.field1

myobj1.field1 = "test"

mutable struct Person
    name::String
    age::Float64
end

logan = Person("Logan", 44)

bob = Person(20, 44)

mutable struct Person2
    name::String
    age::Float64
    isActive

    function Person2(name,age)
        new(name, age, true)
    end
end

newPerson1 = Person2("Logan", 27)

function birthday(person::Person2)
    person.age += 1
end

birthday(newPerson1)
newPerson1.age

#Julia is fast
a = rand(10^7)
sum(a)

using Pkg
Pkg.add("BenchmarkTools")
using BenchmarkTools

C_code = """
#include <stddef.h>

double c_sum(size_t n, double *X) {
    double s = 0.0;
    for(size_t i=0; i<n; ++i) {
        s += X[i];
    }
    return s;
}
"""
const Clib = tempname() # make a temporary file

using Libdl

# compile to a shared library by piping C_code to gcc
# (works only if you have gcc installed):
open(`gcc -fPIC -O3 -msse3 -xc -shared -o $(Clib * "." * Libdl.dlext) -`, "w") do f
    print(f, C_code)
end

#define a Julia funciton that calls the C function:
c_sum(X::Array{Float64}) = ccall(("c_sum", Clib), Float64,
(Csize_t, Ptr{Float64}), length(X), X)

c_sum(a)
sum(a)

c_sum(a) ≈ sum(a) # \approx
apropos("isapprox")
apropos("sum")

c_bench = @benchmark c_sum($a)

println("C: Fastest time was $(minimum(c_bench.times) / 1e6) msec")

d = Dict() # a "dictioanry", i.e. an associative array
d["C"] = minimum(c_bench.times) / 1e6 # in milliseconds
d

using Plots
gr()

t = c_bench.times / 1e6 # times in milliseconds
m, σ = minimum(t), std(t)

histogram(t, bins=500,
    xlim=(m - 0.01, m + σ),
    xlabel="milliseconds",
    ylabel="count",
    label="")

Pkg.add("PyCall")
ENV["PYTHON"] = ""
Pkg.build("PyCall")
using PyCall

# Call a low-level PyCall function to get a Python list, because
# by default PyCall will convert to a NumPy array instead (we benchmark NumPy below)

apy_list = PyCall.array2py(a);#, 1, 1)

# get the Python built-in "sum" function
pysum = pybuiltin("sum")

pysum(a)

pysum(a) ≈ sum(a)

py_list_bench = @benchmark $pysum($apy_list)

d["Python built-in"] = minimum(py_list_bench.times) / 1e6
d

Pkg.add("Conda")

using Conda

Conda.add("numpy")

numpy_sum = pyimport("numpy")["sum"]
apy_numpy = PyObject(a) # converts to a numpy array by default

py_numpy_bench = @benchmark $numpy_sum($apy_numpy)

numpy_sum(apy_list) # python thing

numpy_sum(apy_list) ≈ sum(a)

d["Python numpy"] = minimum(py_numpy_bench.times) / 1e6
d

py"""
def py_sum(a):
    s = 0.0
    for x in a:
        s = s + x
    return s
"""

sum_py = py"py_sum"

py_hand = @benchmark $sum_py($apy_list)

sum_py(apy_list)

sum_py(apy_list) ≈ sum(a)

d["Python hand-written"] = minimum(py_hand.times) / 1e6
d

@which sum(a)

j_bench = @benchmark sum($a)

d["Julia built-in"] = minimum(j_bench.times) / 1e6
d

function mysum(A)
    s = 0.0 # s = zero(eltype(A))
    for a in A
        s += a
    end
    s
end

j_bench_hand = @benchmark mysum($a)

d["Julia hand-written"] = minimum(j_bench_hand.times) / 1e6
d

for (key, value) in sort(collect(d), by=x->x[2])
    println(rpad(key, 20, "."), lpad(round(value, digits=2), 10, "."))
end

# Basic Linear Algebra

A = rand(1:4,3,3)

B = A
C = copy(A)

[ B C]

# Watch out!
A[1]=17
[B C] # B and A are references to the same memory (better for peformances)

x = ones(3)

b = A*x

Asym = A + A'

Apd = A'A

# solve linear system
A\b

# ovedetermined system
# Keep al lrows and only the first 2 colums of `A` to generate `Atall`
Atall = A[:,1:2]
display(Atall)
Atall\b
# returns the solution with the smallest norm

A = randn(3,3)

# The outer product of a vector with itself will result in a singular matrix
#representing a rank deficient least squares problem
[A[:,1] A[:,1]]\b


# Underdetermined systems
Ashort = A[1:2,:]
display(Ashort)
Ashort\b[1:2]
# returns the solution with the smallest norm

# Factorization

using LinearAlgebra

A = randn(3,3)

# One way to perform an LU factorization is with the function `lu`, which returns matrices l and u
# and permutation vector p
l,u,p = lu(A)

# Pivoting is on by default so we can't assume A == LU
display(norm(l*u-A))
display(norm(l*u-A[p,:]))

# To turn off pivoting for LU factorization, use the argument `Val{false}`
l,u,p = lu(A, NoPivot())

# A second way to perform an LU factorization is with the function `lufact`
# Alu = lufact(A) # not working
factorize(A)

# First, what is b given ou solution, x?
x = ones(3)
b = A*x

# Now, prove that you can solve for x

# PA = LU
# A = P'LU
# P'LUx = b
# LUx = Pb
# Ux = L\Pb
# x = U\L\Pb
P = zeros(3,3)
P[1,p[1]] = 1
P[2,p[2]] = 1
P[3,p[3]] = 1

(u\(l\(P*b)))
A\b

det(A)

det(u*l)

Aqr = qr(A[:,1:2])

#Aqr[:Q]

# QR factorization
# Eigenvalues
# SVD

# Diagonal(A)
# Symmetric matrix indication to help julia
#...

n = 1000;
A = randn(n,n);
Asym1 = A + A';
Asym2 = copy(Asym1); Asym2[1,2] += 5eps();
println("Is Asym1 symmetric? ", issymmetric(Asym1));
println("Is Asym2 symmetric? ", issymmetric(Asym2));

@time eigvals(Asym1);
#0.125234 seconds (21 allocations: 7.988 MiB)
@time eigvals(Asym2);
#0.935370 seconds (27 allocations: 7.928 MiB, 0.17% gc time)
@time eigvals(Symmetric(Asym2));
#0.246898 seconds (6.46 k allocations: 8.317 MiB, 2.40% gc time, 32.71% compilation time)

# Generic linear algebra
# wrapping BLAS and LAPACK subroutines
# more types

Ar = convert(Matrix{Rational{BigInt}}, rand(1:10,3,3))/10

x = ones(Int,3)
b = Ar*x

Ar\b
lu(Ar)

λ1, λ2, λ3 = 1//1,1//2,1//4
v1, v2, v3 = [1,0,0],[1,1,0],[1,1,1]
v,Λ = [v1 v2 v3], Diagonal([λ1,λ2,λ3])
A = v*Λ/v
