{-# LANGUAGE DeriveGeneric #-}

module Person where

import Data.ByteString (ByteString)
import Data.Csv
import GHC.Generics (Generic)

import Age

data Person = Person
    { name :: ByteString
    , age :: Age
    -- Uh... https://stackoverflow.com/a/11160193
    -- , address :: ByteString
    } deriving (Generic, Show)

instance FromRecord Person
instance ToRecord Person
