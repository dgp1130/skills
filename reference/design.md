# Design & Architecture

Follow this advice when designing and architecting systems at a higher level.

## Functional

I'm a bit of a functional programming snob and prefer using function paradigms over object-oriented
paradigms. This includes immutable data structures and pure functions. Limit state changes to the
highest level of abstraction which is reasonably possible. Prefer composition over inheritance.

## Code Scaffolding

When scaffolding infrastructure from scratch, start by invoking any official scaffolding tools (such
as via `npm init`) to generate an up-to-date starting point, then iterate on them with any requested
changes.
