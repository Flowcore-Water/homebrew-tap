# Flowcore Water Homebrew Tap

Homebrew formulae for Flowcore Water CLI tools.

## Install

The source repo is private. Set a GitHub token before installing:

```bash
export HOMEBREW_GITHUB_API_TOKEN=$(gh auth token)
brew tap flowcore-water/tap
brew install flowcore
```

If you get a 403 error, ensure your GitHub token has access to the
`Flowcore-Water` org and the `flowcore-mcp` repo.

## Usage

```bash
flowcore --help
flowcore auth login
flowcore wellscope wells search --county Tarrant
flowcore st-mirror sync-status
```

## Update

```bash
brew upgrade flowcore
```

## Uninstall

```bash
brew uninstall flowcore
brew untap flowcore-water/tap
```
