module Lib where

type Alphabet = [Char]

lowerAlphabet :: Alphabet
lowerAlphabet = ['a' .. 'z']

upperAlphabet :: Alphabet
upperAlphabet = ['A' .. 'Z']

digits :: Alphabet
digits = ['0' .. '9']

isLower :: Char -> Bool
isLower char = char `elem` lowerAlphabet

isUpper :: Char -> Bool
isUpper char = char `elem` upperAlphabet

isDigit :: Char -> Bool
isDigit char = char `elem` digits

isMisc :: Char -> Bool
isMisc char = char `notElem` lowerAlphabet ++ upperAlphabet ++ digits

indexOf :: Char -> Alphabet -> Int
indexOf ch [] = undefined
indexOf char (x : xs) = if x == char then 0 else 1 + indexOf char xs

alphabetRotation :: Alphabet -> Int -> Char -> Char
alphabetRotation alphabet rotation char =
  alphabet !! ((indexOf char alphabet + rotation) `mod` length alphabet)

upperRotation :: Int -> Char -> Char
upperRotation = alphabetRotation upperAlphabet

lowerRotation :: Int -> Char -> Char
lowerRotation = alphabetRotation lowerAlphabet

digitRotation :: Int -> Char -> Char
digitRotation = alphabetRotation digits

rotateChar :: Int -> Char -> Char
rotateChar rotation char
  | isLower char = lowerRotation rotation char
  | isUpper char = upperRotation rotation char
  | isDigit char = digitRotation rotation char
  | otherwise = char

caesar :: Int -> String -> String
caesar cipherKey = map (rotateChar cipherKey)

rot13 :: String -> String
rot13 = caesar 13

rot5 :: String -> String
rot5 = caesar 5

rot135 :: String -> String
rot135 [] = []
rot135 (char : xs)
  | isLower char || isUpper char = rotateChar 13 char : rot135 xs
  | isDigit char = rotateChar 5 char : rot135 xs
  | otherwise = char : rot135 xs
