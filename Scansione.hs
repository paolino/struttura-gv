import Data.List
type Spezzata = [(Float,Float -> Float)]

query :: Spezzata -> Float -> Float
query xs x = case find ((< x) . fst) xs of
	Nothing -> error "pippa"
	Just (x0,m) -> m x

--mkSpezzata :: (Float,Float) -> [(Float,Float)] -> ((Float,Float),Spezzata)
mk1 (x,y) (xn,m) = ((x + xn,y + m * x),(x + xn, \q -> y + m * q)) 

mk = snd . mapAccumL mk1 (0,0)
