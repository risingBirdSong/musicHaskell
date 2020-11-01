module Lib
    ( someFunc
    ) where

import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Builder as B
import Data.List
import Data.Foldable
import System.Process
import Text.Printf
volume = 0.5
filename = "test.bin"
wave :: [Float]
wave = map (* volume) $ map (sin) $ map (* step) [0.0..48000]
    where step = 0.05

built = B.toLazyByteString $ fold $ (map (B.floatLE) wave)

save :: FilePath -> IO ()
save filenm = B.writeFile filenm $ built

-- command
-- ffplay -f f32le -ar 48000 test.bin
play :: IO ()
play = do 
    save filename
    _ <- runCommand $ printf "ffplay -f f32le -exitonkeydown -ar 48000 %s" filename
    return ()

someFunc :: IO ()
someFunc = putStrLn "someFunc"
