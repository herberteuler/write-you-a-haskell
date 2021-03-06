import Eval
import Parser (parseExpr, parseTokens)

import Control.Monad.Trans
import System.Console.Haskeline

process :: String -> IO ()
process input = do
  let tokens = parseTokens input
  print tokens
  let ast = parseExpr input
  case ast of
    Left err -> do
      putStrLn "Parser Error:"
      print err
    Right ast -> print $ runEval ast

main :: IO ()
main = runInputT defaultSettings loop
  where
  loop = do
    minput <- getInputLine "Happy> "
    case minput of
      Nothing -> outputStrLn "Goodbye."
      Just input -> (liftIO $ process input) >> loop
