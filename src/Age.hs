module Age (Age, unAge) where

import Data.Csv
import Control.Applicative

newtype Age = Age { unAge :: Int }
    deriving (Show)

instance ToField Age where
    toField = toField . unAge

instance FromField Age where
    parseField i = do
        -- Do we need Integer or some other underlying representation?
        int <- (parseField i :: Parser Int)

        if int `elem` [0..150] then
            pure (Age int)
        else
            fail $ "expected Age, must be in range 0-150. Got: " ++ show i
