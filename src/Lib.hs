{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE StrictData #-}
{-# LANGUAGE DeriveGeneric #-}

module Lib
    ( solution
    ) where


import Prelude hiding (readFile)
import Data.ByteString.Lazy (ByteString, readFile)
import qualified Data.ByteString.Lazy.Char8 as BSL
import Data.Either
import Data.Vector (Vector)
import Data.Text (Text)
import Data.Csv
import Age
import GHC.Generics (Generic)

data Person = Person
    { name :: Text
    , age :: Age -- Upgrade to Age
    , address :: Text
    } deriving (Generic, Show)

instance FromRecord Person
instance ToRecord Person


-- Curious if there's a way to use a Validation-like data type that returns
-- The successfully parsed bits and the failed bits
-- something like :: ([Failure], [Success])
-- Or if that would mean having to write the actual Parser itself.
solution :: IO ()
solution =
    ("./file.csv" & readFile)
        -- What's preventing inference here?
        >>= (decode HasHeader :: ByteString -> Either String (Vector Person))
        # either show show
        # putStrLn

(#) :: (a -> b) -> (b -> c) -> a -> c
(#) = flip (.)

(&) :: a ->  (a -> b) -> b
a & fn = fn a
