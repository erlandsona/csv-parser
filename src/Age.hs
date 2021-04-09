module Age (Age, unAge) where

import Data.Csv
import Control.Applicative

newtype Age = Age { unAge :: Int }
    deriving (Show)

instance ToField Age where
    toField = toField . unAge

instance FromField Age where
    parseField i = do
        int <- (parseField i :: Parser Int)

        if 0 < int && int < 150 then
            pure (Age int)
        else
            fail "Didn't get proper input to construct an Age"
