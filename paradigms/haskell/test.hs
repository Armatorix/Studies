doubleMe :: Integer -> Integer
doubleMe x = x + x
scalarproduct :: Num a => [a] -> [a] -> a
scalarproduct x y = schelper (zip x y)
 where            
  schelper [] = 0
  schelper (x:xs) = (fst x * snd x) + (schelper xs)
split :: [a] -> ([a],[a])
split ([]) = ([],[])
split (x:[]) = ([x],[])
split (x1:x2:xs) = ((x1:r1), (x2:r2)) 
 where
  r = split xs
  r1 = fst r
  r2 = snd r

permutacje :: Eq a => [a] -> [[a]]
permutacje []     = [[]]
permutacje (x:xs) = [spermutowane | p <- permutacje xs, spermutowane <- powstawiaj x p]
 where
  powstawiaj el []     = [[el]]
  powstawiaj el (y:ys) = (el:y:ys) : map (y:) (powstawiaj el ys)
