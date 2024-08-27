module Lib
    ( someFunc
    ) where
import Data.Char (isPrint, isSeparator)

type NumberedLine = (Maybe Int, String)
type NumberedLines = [NumberedLine]

numberAllLines :: [String] -> NumberedLines
numberAllLines inputLines =
    let go :: Int -> [String] -> NumberedLines
        go _ [] = []
        go counter (x : xs) = (Just counter, x) : go (counter + 1) xs
    in go 1 inputLines

isEmpty :: String -> Bool
isEmpty input = null input || all (\char -> not (isPrint char) || isSeparator char) input

isNotEmpty :: String -> Bool
isNotEmpty input = not (isEmpty input)

numberLines :: (String -> Bool) -> (String -> Bool) -> [String] -> NumberedLines
numberLines shouldIncrement shouldNumber text =
    let aux :: Int -> [String] -> NumberedLines
        aux _ [] = []
        aux counter (x : xs) =
            let mNumbering = if shouldNumber x then Just counter else Nothing
                newCounter = if shouldIncrement x then counter + 1 else counter
            in (mNumbering, x) : aux newCounter xs
    in aux 1 text

someFunc :: IO ()
someFunc = putStrLn "someFunc"
