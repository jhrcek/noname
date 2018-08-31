#!/usr/bin/env stack
-- stack script --resolver lts-12.8 --package turtle --no-nix-pure
{-# LANGUAGE OverloadedStrings #-}

import Turtle

main :: IO ()
main = sh $ do
  outPath <- build -- builds NixOS for our server
  echo outPath

build :: Shell Line
build =
    inproc "nix-build" ["server.nix", "--no-out-link"] empty
