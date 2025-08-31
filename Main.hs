{-# LANGUAGE Haskell2010
  , TypeApplications
#-}

{-# OPTIONS_GHC -Wall #-}

module Main
  ( main
  ) where

import System.Environment
  ( getArgs )

import Sort
  ( sort0
  , sort1
  , sort2
  , sort3
  )

main :: IO ()
main = do
    [c, zn] <- getArgs
    let n = read @Int zn
        sn = [n-1,n-2..0]
    print $ case c of
        "0" -> sort0 sn
        "1" -> sort1 sn
        "2" -> sort2 sn
        "3" -> sort3 sn
        _   -> undefined
