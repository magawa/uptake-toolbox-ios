# Uptake Toolbox
![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat) ![API docs](http://mobile-toolkit-docs.services.common.int.uptake.com/docs/uptake-toolbox-ios/badge.svg)

All the tools fit for Foundation

## Description
The `UptakeToolbox` module contains all the functions, extension, helpers, &c. that are of common use across projects and don't require `UIKit` or any other module outside of `Foundation`.

Functionality shouldn't be added to `UptakeToolbox` unless it has demonstrated applicability across multiple projects. Remember:

> “Duplication is far cheaper than the wrong abstraction.”  
> –[The Wrong Abstraction](https://www.sandimetz.com/blog/2016/1/20/the-wrong-abstraction)

## Debugging
Uptake Toolbox will print debugging messages to console whenever the environment variable `UPTAKE_TOOLBOX_DEBUGGING` is set to a non-null value. Uptake Toolbox's messages will be prepended with "🛠".
