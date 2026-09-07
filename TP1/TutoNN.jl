using Flux#, Flux.Data.MNIST
using MLDatasets
using Flux: onehotbatch, argmax, crossentropy, throttle
using Base.Iterators: repeated
using Images
using Optimisers
using Statistics

#imgs = MNIST.traindata()

train_x, train_y = MNIST(split=:train)[:]
colorview(Gray, train_x[:,:,800])

train_y[800]

train_x[:,:,100]

typeof(train_x)

fpt_imgs = train_x

typeof(fpt_imgs[:,:,1])

[ fpt_imgs[:,:,i][:] for i in 1:10]

# vectorize(x) = x[:]
# vectorized_imgs = vectorize.(fpt_imgs);

vectorized_imgs = [ fpt_imgs[:,:,i][:] for i in 1:60000 ]

#sum(vectorized_imgs[1])

X = hcat(vectorized_imgs...)
size(X)

onefigure = X[:,2]
t1 = reshape(onefigure,28,28)
colorview(Gray,t1)

labels = train_y
labels[3]

Y = onehotbatch(labels, 0:9)

m = Chain(
  Dense(28^2, 32, relu),
  Dense(32, 10),
  softmax)

m(onefigure)

loss(x, y) = Flux.crossentropy(x, y)
accuracy(x, y) = mean(argmax(x; dims = 1) .== argmax(y; dims = 1))
# datasetx = repeated((X, Y), 200)
# C = collect(datasetx);

evalcb = (m) -> @show(loss(m(X), Y))
evalcb2 = (m) -> @show(accuracy(m(X),Y))
#ps = Flux.params(m)

Flux.crossentropy(m(X), Y)

for i in 1:100
  opt_state = Optimisers.setup(Optimisers.Adam(), m)
  ∇m = gradient(m -> loss(m(X), Y), m)[1]
  opt_state, m = Optimisers.update!(opt_state, m, ∇m)
  evalcb(m)
  evalcb2(m)
end


test_x, test_y = MNIST(split=:test)[:]

tX = hcat([ test_x[:,:,i][:] for i in 1:10000 ]...);
test_image = m(tX[:,1])

argmax(test_image) - 1

t1 = reshape(tX[:,1],28,28)
colorview(Gray, t1)

onefigure = X[:,2]
m(onefigure)

Y[:,2]