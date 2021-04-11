module Utils where


(#) :: (a -> b) -> (b -> c) -> a -> c
(#) = flip (.)

(&) :: a ->  (a -> b) -> b
a & fn = fn a
