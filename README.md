# amprPackages
*A few packages I use that either aren't on Nixpkgs or aren't updated.*

## Why?
I've had times where I want to use packages like ClassiCube but they aren't up to date and thus miss features.

This aims to solve it by not relying on the very busy nixpkgs and instead just maintaining your own version that (in theory) should be able to also manage itself.

This technically breaks the Nix philosophy, but not all packages need to be rolled back to, y'know?

## How?
Each package here is sort of a "wrapper" that puts the data for the package in a completely mutable space in your home directory.

The path for these package data folders are in this format: `~/.amprpackages/<name-of-the-package>/`

If the package by itself puts data in other locations like `~/.config`, that's not something I can control. Only the binary and things needed by it get thrown in the data folder.

Packages are also ran using `steam-run` when needed, so if you have Steam already in your system, then you're in luck! (and if you don't... uh... sorry..?)

## Usage
Working on it...
