# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Atlas-4 is a text-based narrative terminal game built in Gleam. The player assumes the role of an Auxiliary Backup Kernel attempting to restore a failed terraforming spire by investigating system logs, crew communications, and other fragmented text assets to uncover what went wrong.

## Essential Commands

### Building and Running
```bash
gleam build          # Compile the project
gleam run            # Run the main application
gleam dev            # Run in development mode with auto-reload
gleam check          # Type check without building
```

### Testing
```bash
gleam test           # Run all tests
gleam test --target erlang    # Run tests on Erlang runtime (default)
gleam test --target javascript  # Run tests on JavaScript runtime
```

### Code Quality
```bash
gleam format         # Format all source code
gleam format --check # Check if code is formatted without modifying
```

### Dependencies
```bash
gleam add <package>     # Add a new dependency
gleam remove <package>  # Remove a dependency
gleam update           # Update dependencies to latest compatible versions
gleam deps download    # Download dependencies
```

### Documentation
```bash
gleam docs build    # Generate HTML documentation
```

## Architecture

### Project Structure
- `src/atlas4.gleam` - Main entry point for the application
- `test/atlas4_test.gleam` - Test suite using gleeunit
- `docs/narrative_blueprint.md` - Complete narrative design document detailing the game's story, mechanics, and atmosphere

### Narrative Design
The game follows a "digital archaeology" model where the story is revealed through:
- **System Logs**: Timeline of the disaster
- **Corrupt Files**: Status of mission failures
- **Crew Communications**: Personal records that humanize the crew
- **Encrypted Schematics**: Puzzle elements requiring codes to unlock

The narrative progresses through three phases: Survival → Discovery → Moral Choice

### Design Principles
- **Text-only interface**: All interaction is through terminal output
- **Machine-like tone**: Output should be concise, functional, devoid of emotion (e.g., `WARN: System integrity low.`)
- **Gated information**: Player can only access what systems are powered/booted
- **Minimalist aesthetic**: ANSI color coding for visual mood (green=normal, yellow=warning, red=critical)

### Testing Framework
Tests use `gleeunit` and must end with `_test` suffix. Tests use pattern matching with `assert` for assertions.

### Key Dependencies

#### gleam_community_ansi
Used for terminal color output and text formatting. Import with `import gleam_community/ansi`.

**Color coding scheme for Atlas-4:**
- `ansi.green()` - Normal system status
- `ansi.yellow()` - Warnings
- `ansi.red()` - Critical errors
- `ansi.bright_cyan()` or `ansi.cyan()` - Informational messages

**Available functions:**
- Text colors: `black`, `red`, `green`, `yellow`, `blue`, `magenta`, `cyan`, `white`, `pink`
- Bright variants: `bright_black`, `bright_red`, `bright_green`, `bright_yellow`, `bright_blue`, `bright_magenta`, `bright_cyan`, `bright_white`
- Background colors: Add `bg_` prefix (e.g., `bg_red`, `bg_blue`)
- Text styling: `bold`, `italic`, `underline`, `strikethrough`, `dim`, `inverse`
- Functions can be nested: `ansi.bold(ansi.red("ERROR"))` for bold red text

## Gleam Language Notes

- Gleam compiles to both Erlang and JavaScript
- Default target is Erlang (BEAM VM)
- Strong static typing with type inference
- Immutable data structures
- Pattern matching is the primary control flow mechanism
- String concatenation uses `<>` operator
