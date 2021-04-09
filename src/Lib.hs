{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE StrictData #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE LambdaCase #-}

module Lib
    ( solution
    ) where


import Prelude hiding (readFile)
import Data.ByteString.Lazy (readFile)
import qualified Data.ByteString.Lazy.Char8 as BSL
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


solution :: IO ()
solution = do
    -- usually I'd stick this reference in a config
    csv <- readFile "./file.csv"
    BSL.putStrLn csv

    let decoded:: Either String (Vector Person)
        -- What if we want to be able to ignore un-formed rows?
        decoded = decode HasHeader csv

    foldMap show decoded
        |> putStrLn


(|>) :: a ->  (a -> b) -> b
a |> fn = fn a
