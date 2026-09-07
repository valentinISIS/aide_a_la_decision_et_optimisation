using DataFrames
using Statistics
using GLM

aq = [10.0   8.04  10.0  9.14  10.0   7.46   8.0   6.58
       8.0   6.95   8.0  8.14   8.0   6.77   8.0   5.76
      13.0   7.58  13.0  8.74  13.0  12.74   8.0   7.71
       9.0   8.81   9.0  8.77   9.0   7.11   8.0   8.84
      11.0   8.33  11.0  9.26  11.0   7.81   8.0   8.47
      14.0   9.96  14.0  8.1   14.0   8.84   8.0   7.04
       6.0   7.24   6.0  6.13   6.0   6.08   8.0   5.25
       4.0   4.26   4.0  3.1    4.0   5.39  19.0  12.50 
      12.0  10.84  12.0  9.13  12.0   8.15   8.0   5.56
       7.0   4.82   7.0  7.26   7.0   6.42   8.0   7.91
       5.0   5.68   5.0  4.74   5.0   5.73   8.0   6.89]

df = DataFrame(aq, :auto)

newnames = vec(string.(["x", "y"], [1 2 3 4]))

rename!(df, newnames)

DataFrame(aq, [:x1, :y1, :x2, :y2, :x3, :y3, :x4, :y4])

df.y1

df."y1"

df[:, :y1]

df[:, "y1"]

select!(df, r"x", :)

describe(df, mean => :mean, std => :std)

describe(df, mean => "mean", std => "std")

df.id = 1:nrow(df) # also writing axes(df, 1) on the right handside should work
df

ncol(df)

select(df, :id, :)

df

# see DataFrameMeta also

Matrix(df)

xlims = collect(extrema(Matrix(select(df, r"x"))) .+ (-1, +1))
ylims = collect(extrema(Matrix(select(df, r"y"))) .+ (-1, +1))

using TidierPlots

i=1
my_plots = []

top + blank + middle + right +
    plot_layout(ncol = 2, nrow = 2, widths = c(3, 1), heights = c(1, 2))

for i in 1:4
    x = Symbol("x", i)
    y = Symbol("y", i)
    model = lm(term(y)~term(x), df)
    a, b = round.(coef(model), digits=2)
    c = round(100 * r2(model), digits=2)

    my_plot = ggplot(
        DataFrame(xlim = xlims, ylim = predict(model, DataFrame(x => xlims)))) +
        geom_line(aes(x = :xlim, y = :ylim))

    my_plot2 = ggplot(df) +
        geom_point(aes(x = x, y = y)) +
        lims(x = xlims, ylims) +
        labs(x = "x$i", y = "y$i",
            title = string("R²=$c%, $y=$a+$b$x"))

    my_plot + my_plot2 +
    plot_layout(ncol = 1, nrow = 1)
    
    push!(my_plots, my_plot)
end

plotlyjs()

plot = Plots.plot
scatter = Plots.scatter

plot(plot([sin, cos], 1, ylims = (-1, 1), leg = false), scatter([atan, cos], 1, ylims = (-1, 1.5), leg = false), plot(log, 1, ylims = (0, 2), leg = false), layout = l, xlims = (1, 2π))

for i in 1:4
    i = 1
    x = Symbol("x", i)
    y = Symbol("y", i)
    PlotlyJS.scatter(df[:, x], df[:, y])

end

plt = pyimport("matplotlib.pyplot")

fig, axs = PyPlot.subplots(2, 2)
fig.tight_layout(pad=4.0)
for i in 1:4
    x = Symbol("x", i)
    y = Symbol("y", i)
    model = lm(term(y)~term(x), df)
    axs[i].plot(xlims, predict(model, DataFrame(x => xlims)), color="orange")
    axs[i].scatter(df[:, x], df[:, y])
    axs[i].set_xlim(xlims)
    axs[i].set_ylim(ylims)
    axs[i].set_xlabel("x$i")
    axs[i].set_ylabel("y$i")
    a, b = round.(coef(model), digits=2)
    c = round(100 * r2(model), digits=2)
    axs[i].set_title(string("R²=$c%, $y=$a+$b$x"))
end



plotlyjs()

l = @layout([[a; b] c])
p = plot(plot([sin, cos], 1, ylims = (-1, 1), leg = false), scatter([atan, cos], 1, ylims = (-1, 1.5), leg = false), plot(log, 1, ylims = (0, 2), leg = false), layout = l, xlims = (1, 2π))
anim = Animation()
for x = range(1, stop = 2π, length = 20)
    plot(push!(p, x, Float64[sin(x), cos(x), atan(x), cos(x), log(x)]))
    frame(anim)
end
gif(anim, "assets/anim_plotlyjs_ref031.gif")



using Colors
using Plots
using PlotlyJS
