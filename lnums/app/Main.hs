module Main (main) where

import System.Environment (getProgName, getArgs)

printHelpText :: String -> IO ()
printHelpText message = do
    putStrLn (message ++ "\n")
    programName <- getProgName
    putStrLn ("Usage: " ++ programName ++ " <filename>")

parseArguments :: [String] -> Maybe FilePath
parseArguments [filePath] = Just filePath
parseArguments _ = Nothing

readLines :: FilePath -> IO [String]
readLines filePath = do
    contents <- readFile filePath
    return (lines contents)

main :: IO ()
main = do
    cliArgs <- getArgs
    let mFilePath = parseArguments cliArgs
    maybe
        (printHelpText "Missing filename")
        putStrLn
        mFilePath
