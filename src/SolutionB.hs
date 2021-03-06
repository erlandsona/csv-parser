{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE StrictData #-}
{-# LANGUAGE DeriveGeneric #-}

module SolutionB where


import Data.ByteString (ByteString)
import qualified Data.ByteString as B
import Data.Csv hiding (decode, Parser)
import Data.Csv.Incremental
import System.IO


import Age
import Person


solutionB :: IO ()
solutionB = withFile "file.csv" ReadMode $ flip (folder []) (decode HasHeader)

-- Can a Foldable instance be written for Parser here?
folder :: [Either String Person] -> Handle -> Parser Person -> IO ()
folder acc handle =
    \case
        Fail input err ->
            putStrLn (err ++ show input)
        Done ls ->
            putStrLn (show (ls ++ acc))
        Many ls kont ->
            feed kont handle >>= -- is do prefered here?
                folder (acc ++ ls) handle

feed :: (ByteString -> Parser Person) -> Handle -> IO (Parser Person)
feed kont csv = do
    isEof <- hIsEOF csv
    if isEof
        then return $ kont B.empty
        else kont <$> B.hGetSome csv 4096 -- 4096?
