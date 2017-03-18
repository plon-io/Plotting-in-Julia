#******************************************************************************#
#                               Introduction                                   #
#******************************************************************************#

# PyPlot is package for Julia that able you to use matplotlib library.

# First step to start plotting in Julia using Pyplot is install PyPlot package.
# You should do it only once.

ENV["PYTHON"] = ""
Pkg.add("PyPlot")

# And start using PyPlot module.
using PyPlot

# Now you can working.

# To do plot use plot(): 

x = linspace(-2*π, 2*π, 2000) # Generating 2000 sclars from -2π to 2π
y = sin(x)
plot(x,y)

# If you need two lines in one plot:

x = linspace(-2*π, 2*π, 2000) # Generating 2000 sclars from -2π to 2π
y = sin(x)
z = cos(x)
plot(x,y)
plot(x,z)

# But it's only raw chart. Let's describe it:

plot(x,y, color = "green", linewidth = "2.0")
plot(x,z, color = "red", linewidth = "2.0", "--")
title("Sine wave")
ylabel("Amplitude")
xlabel("Time")
grid(true)
text(0, 0, "0")
legend(["sin(x)","cos(x)"], loc = "lower left", fontsize = 12, borderpad = 0.3,
    handlelength=3) 

# You can do subplots using subplot(nrows,ncols, plot_number):

sinh = sinh(x)
cosh = cosh(x)

subplot(221)
    plot(x,y)
    legend(["sin(x)"], fontsize = 8,  loc = "best" )
subplot(222)
    plot(x,z)
    legend(["cos(x)"], fontsize = 8,  loc = "best"  )
subplot(223)
    plot(x,sinh)
    legend(["sinh(x)"], fontsize = 8,  loc = "best"  )
subplot(224)
    plot(x,cosh)
    legend(["cosh(x)"], fontsize = 8,  loc = "best"  )
    
#******************************************************************************#
#                               Scatter plots                                  #
#******************************************************************************#    
    
n = 1024
X = rand(1,1,n)
Y = rand(1,1,n)
colors = rand(1,1,n)

scatter(X,Y, s = 50 ,c = colors) 
scatter(X,Y, s = 50 ,c = colors, marker = "^", alpha = .5) 

#******************************************************************************#
#                                  Bar plots                                   #
#******************************************************************************#
    
n = 15
X = range(0,n)
Y1 = (1-X/n) * rand(1:n)
Y2 = (1-X/n) * rand(1:n)
axes([0.025,0.025,0.95,0.95])
bar(X, +Y1, facecolor="#9999ff", edgecolor="white")
bar(X, -Y2, facecolor="#ff9999", edgecolor="white")    
margins(0.05) # 5% margins

# Code below generating describe under or above each bar.

for (x,y) in zip(X,Y1)
    text(x+0.4, y+0.05, "$(round(y,2))", ha="center", va= "bottom")
end


for (x,y) in zip(X,Y2)
    text(x+0.4, -y-0.05, "$(round(y,2))",  ha="center", va= "top")
end
    
#******************************************************************************#
#                               Contour plots                                  #
#******************************************************************************#    

f(x,y) = (1-x/2+x^5+y^3)*exp(-x^2-y^2)    
n = 256
x = linspace(-3,3,n) 
y = linspace(-3,3,n)   
z = zeros(n,n)
for i in 1:n
    for j in 1:n
        z[i,j] = f(x[j],y[i])
    end
end
X = repmat(x',n,1)
Y = repmat(y,1,n)    

contourf(X, Y, z, 8, alpha=.75, cmap="jet")
 
# Easier way to get contour plots is to use Gadfly package:
Pkg.add("Gadfly")

using Gadfly

plot((x,y) -> (1-x/2+x^5+y^3)*exp(-x^2-y^2), -4, 4, -4, 4)

# You can use more parameters. To get more information about Gadfly contour 
# plots check this topic: https://github.com/dcjones/Gadfly.jl/issues/293

plot((x,y) -> (1-x/2+x^5+y^3)*exp(-x^2-y^2), -4, 4, -4, 4, 
    Stat.contour(samples = 200, levels = linspace(-1,1,25)))
    
# In this example we used levels = linspace(-1,1,25) to show 25 lines from -1 
# to 1 include 0. If you want to see more lines you can precise it in 
# levels parameter.
    
#******************************************************************************#
#                                Pie charts                                    #
#******************************************************************************#  

# Back to using PyPlot

using PyPlot

labels = ["PyPlot";"Plots";"Gadfly"]
colors = ["yellowgreen";"lightskyblue";"lightcoral"]
sizes = NaN*zeros(3)
explode = zeros(length(sizes))
explode[2] = 0.1 # Move slice 2 out by 0.1
sizes = [80,15,10]
font = Dict("fontname"=>"Sans","weight"=>"semibold")
axes([0.025,0.025,0.95,0.95])
pie(sizes,
    labels=labels,
    shadow=true,
    startangle=90,
    explode=explode,
    colors=colors,
    autopct="%1.1f%%",
    textprops=font
)
    
#******************************************************************************#
#                                   3D Plots                                   #
#******************************************************************************#

# Example no. 1

f(x) = (x[1]^2 + x[2]^2)

n = 100
x = linspace(-1, 1, n)
y = linspace(-1,1,n)

xgrid = repmat(x',n,1)
ygrid = repmat(y,1,n)

z = zeros(n,n)

for i in 1:n
    for j in 1:n
        z[i:i,j:j] = f([x[i],y[j]])
    end
end


plot_wireframe(xgrid,ygrid,z) 

# Example no. 2

f(x,y) = sin(x)*cos(y)

n = 100
x = linspace(-2, 2, n)
y = linspace(-1, 1,n)

xgrid = repmat(x',n,1)
ygrid = repmat(y,1,n)

z = zeros(n,n)
for i in 1:n
    for j in 1:n
        z[i,j] = f(x[j],y[i])
    end
end

plot_surface(xgrid,ygrid,z, rstride=1, cstride=1, cmap="coolwarm",
                       linewidth=0) 
                       
# More 3D plots examples you can find there:
# http://matplotlib.org/mpl_toolkits/mplot3d/tutorial.html
 
#******************************************************************************#
#                               Plots package                                  #
#******************************************************************************#    
    
# You can use simpliest package - Plots.  
Pkg.add("Plots")

using Plots

x = linspace(-2*π, 2*π, 2000) # Generating 2000 scalars from -2π to 2π
y = sin(x)
z = cos(x)
plot(x,y)
plot!(x,z)

# You can find more about plots there:
# https://en.wikibooks.org/wiki/Introducing_Julia/Plotting.

# To master skill in PyPlot you should visit this link:
# http://matplotlib.org/contents.html
# If you prefer Gadfly, visit manual page:
# http://gadflyjl.org/stable/
    
    
    
    
    
    
    
    
    
    
    