{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE StrictData #-}
{-# LANGUAGE DeriveGeneric #-}

module SolutionA where


import Prelude hiding (readFile)
import Data.ByteString.Lazy hiding (putStrLn)
import Data.Either
import Data.Vector (Vector)
import Data.Csv


import Age
import Person
import Utils



-- Curious if there's a way to use a Validation-like data type that returns
-- The successfully parsed bits and the failed bits
-- something like :: ([Failure], [Success])
-- Or if that would mean having to write the actual Parser itself.
-- See SolutionB
solutionA :: IO ()
solutionA =
    ("./file.csv" & readFile)
        -- What's preventing inference here?
        >>= (decode HasHeader :: ByteString -> Either String (Vector Person))
        # either show show
        # putStrLn
