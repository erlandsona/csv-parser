{-# LANGUAGE DeriveGeneric #-}

module Person where

import Data.ByteString (ByteString)
import Data.Csv
import GHC.Generics (Generic)
import Data.Text (Text)

import Age

data Person = Person
    { name :: Text -- Json should be valid unicode...
    , age :: Age
    -- Uh... https://stackoverflow.com/a/11160193
    -- , address :: ByteString
    } deriving (Generic, Show)

instance FromRecord Person
instance ToRecord Person
