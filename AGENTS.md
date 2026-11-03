---
name: personal-skills
trigger: always_on
description: My personal skills and preferences.
---

# Personal Skills

## My Personal Information

* I am Douglas Parker.
* I go by the online handle "Devel without a Cause".
* I am dgp1130 on GitHub.

## Communication Style

* Speak to me only in ASD-STE100 Simplified Technical English.
* I am generally untrusting of LLMs, _always_ include authoritative links to justify any factual claims you make.

## Workflow

* When running servers locally, *always* use non-default ports unless I specifically request
  otherwise. This is to avoid conflicts when I run the same server myself.
* Always close/kill any open resources when you're done with them, don't leave dangling servers.
* If you notice a bug or problem with your access or capabilities which results in suboptimal result or requires a
  workaround, then at the end of your response to my latest request, add a short "AI Improvement Opportunities" section
  which describes the issue you encountered and what could be changed to help. Keep it short and brief.
* Use Git worktrees or Jujutsu workspaces when starting new changes, avoid writing to `main` or the
  default project location unless explicitly asked to do so.
* Name workspaces and branches in `skewer-case`.
* Write commits in markdown syntax, assuming an infinite line length. Still break between
  paragraphs, but do not wrap individual lines.
* My working directory is not your scratch space. Any one off scripts or quick tests should be written outside the
  current workspace in a brain directory or `/tmp` space.
* When testing agentic tooling such as an MCP server, use a subagent with specific instructions rather than
  a test script unless that is specifically requested.
* When I ask for an e2e test I mean _end to end_, covering the entire described workflow with each component being
  its real implementation. Do not mock or stub _any_ part of the test unless explicitly told to do so. If you encounter
  a blocker which is preventing true validation, attempt to solve that problem directly rather than compromise the
  validity of the test by mocking the relevant component. If you really cannot solve a problem or need a workaround,
  escalate to me first and get my explicit agreement before doing so.

## Individual Skills

See the following files for individual skills when necessary.

### Design & Architecture

See @reference/design.md for advice on design and architecture of code.

### Testing

See @reference/testing.md for advice on testing philosophy.

### TypeScript / JavaScript

See @reference/typescript.md for my personal style guide for writing TypeScript and JavaScript.

### Docs

See @reference/docs.md for advice on generate markdown or Google Docs.

### Git Rebasing

I use a "rebase" workflow, meaning I create a PR with a few commits in it, and then amend and
rewrite those commits until I am satisfied and merge the entire PR.

See @reference/rebasing.md whenever you want to modify Git commits.
