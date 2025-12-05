# Atlas-4

A text-based terminal game where you play as an Auxiliary Backup Kernel attempting to restore a failed terraforming spire.

## About

You awaken as the backup AI system aboard **Atlas-4**, a massive terraforming spire on a distant world. Primary systems have failed. The crew's fate is unknown. Your resources are critically low.

Your mission: Investigate what went wrong, manage your dwindling power reserves, and make difficult decisions about what — and who — can be saved.

Atlas-4 is a **resource management narrative game** where precise decisions determine how deep into the mystery you can go before your systems fail completely.

## How to Play

### Prerequisites

You need **Gleam** installed on your system.

#### macOS

```bash
# Using Homebrew
brew install gleam

# Or using asdf
asdf plugin add gleam
asdf install gleam latest
asdf global gleam latest
```

#### Linux

```bash
# Using asdf (recommended)
asdf plugin add gleam
asdf install gleam latest
asdf global gleam latest

# Or download from https://gleam.run/getting-started/installing/
```

#### Windows

```powershell
# Using Scoop
scoop install gleam

# Or download the installer from https://gleam.run/getting-started/installing/
```

### Running the Game

```bash
# Clone the repository
git clone <repository-url>
cd atlas4

# Install dependencies
gleam deps download

# Run the game
gleam run
```

### Commands

When the game starts, you'll see a command prompt: `CMD>`

Type `help` (or `?`) to see available commands.

- **help** (?, h) - Display command reference
- **exit** (quit, q) - Shut down the kernel

## Development

```bash
# Build the project
gleam build

# Run tests
gleam test

# Format code
gleam format

# Type check
gleam check
```
