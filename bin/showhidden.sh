#!/bin/bash

# turns on hidden files in the MacOS Finder

defaults write com.apple.finder AppleShowAllFiles TRUE
killall Finder

