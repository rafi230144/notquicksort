{-# LANGUAGE Haskell2010
  , BangPatterns
  , LambdaCase
  , ScopedTypeVariables
#-}

{-# OPTIONS_GHC -Wall #-}

module Sort
  ( sort0
  , sort1
  , sort2
  , sort3
  ) where

import Data.List
  ( partition )

{- | Forces spine of 'Data.List.List' -}
{-# INLINEABLE force #-}
force :: forall a. [a] -> [a]
force = \ sa -> case sa of
    _ : sa' -> force sa' `seq` sa
    []      -> []

{-# INLINEABLE sort0 #-}
sort0 :: forall a.
    Ord a =>
    [a] -> [a]
sort0 = \case
    a : sa' ->
        let left = filter (< a) sa'
            right = filter (>= a) sa'
        in  sort0 left ++ [a] ++ sort1 right
    []      -> []

{-# INLINEABLE sort1 #-}
sort1 :: forall a.
    Ord a =>
    [a] -> [a]
sort1 = \case
    a : sa' ->
        let (left, right) = partition (< a) sa'
        in  sort1 left ++ [a] ++ sort1 right
    []      -> []

{-# INLINEABLE sort2 #-}
sort2 :: forall a.
    Ord a =>
    [a] -> [a]
sort2 = \case
    a : sa' ->
        let !(left, right) = partition (< a) sa'
        in  sort2 left ++ [a] ++ sort2 right
    []      -> []

{-# INLINEABLE sort3 #-}
sort3 :: forall a.
    Ord a =>  
    [a] -> [a]
sort3 = \case 
    a : sa' ->
        let (left, right) = partition (< a) sa'
        in  force left `seq` force right `seq` sort3 left ++ [a] ++ sort3 right
    []      -> []
