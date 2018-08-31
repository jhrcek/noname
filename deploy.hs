#!/usr/bin/env stack
-- stack script --resolver lts-12.8 --package turtle,neat-interpolation --no-nix-pure
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

import NeatInterpolation (text)
import Turtle hiding (text)

-- Path of the NixOS server resulting from the build
newtype NixOS = NixOS Text
-- IP Address of the remote server
newtype Server = Server Text

main :: IO ()
main = sh $ do
  server <- getServer
  path <- build -- builds NixOS for our server
  upload path server
  activate path server

getServer :: Shell Server
getServer = do
    line <- single $ input "server-address.txt"
    return . Server $ lineToText line

build :: Shell NixOS
build = do
    line <- single $ inproc "nix-build" ["server.nix", "--no-out-link"] empty
    return . NixOS $ lineToText line

upload :: NixOS -> Server -> Shell ()
upload (NixOS path) (Server server) =
    procs cmd args empty
  where
    cmd = "nix-copy-closure"
    args = ["--use-substitutes", "--to", server, path]

activate :: NixOS -> Server -> Shell ()
activate (NixOS path) (Server server) =
    procs cmd args empty
  where
    cmd = "ssh"
    args = [server, remoteCommand]
    remoteCommand =
      [text|
        sudo nix-env --profile $profile --set $path
        sudo $profile/bin/switch-to-configuration switch
      |]
    profile = "/nix/var/nix/profiles/system"
