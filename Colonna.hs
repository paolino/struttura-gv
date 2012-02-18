import Data.List
x % y = let
	r = floor (x / y)
	in x - fromIntegral r * y


c y0 y t m n = ((y t + m n) % y0) > y0 / 2

s c y0 y t m ns = length . filter id . map (c y0 y t m) $ ns

y0 = 3
x0 = 2


l = 16

y x = if x < l/2 then x/2 else l/4 - 0.5 * (x - l/2) 

ran = 10
m n = maximum [y (fromIntegral n * x0 + d) | d <- take (ran + 1) [0 , x0/ fromIntegral ran ..]]

ran2 = 100 
dy t = y0/(fromIntegral ran2) * (t * fromIntegral ran2)

v t = s c y0 dy t m [0 .. 7]
