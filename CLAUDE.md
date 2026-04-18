# Homebrew Tap — Agent Instructions

Read DEAR_AGENT.md if it exists, otherwise use this file.

## What This Repo Is

A Homebrew tap containing formulae for Flowcore Water CLI tools. The primary
formula installs `flowcore` and `flowcore-mcp` from the flowcore-mcp repo.

## Formula Location

All formulae live in `Formula/`. Homebrew discovers them automatically.

## Updating a Formula

When a new version of flowcore-mcp is released:
1. Update the `tag:` and `revision:` in `Formula/flowcore.rb`
2. Run `brew audit --strict Formula/flowcore.rb` locally
3. Push to dev, then merge to main

## What NOT to Do

- Don't add formulae for deprecated tools
- Don't modify the formula without testing `brew install` locally
- Don't add bottles (we build from source)
