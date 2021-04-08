#!/bin/sh

test -f ~/.Xresources && xrdb -merge -I"$HOME" ~/.Xresources
