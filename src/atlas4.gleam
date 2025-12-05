import gleam/erlang/process
import gleam/float
import gleam/int
import gleam/io.{print, println}
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/string
import gleam/time/duration
import gleam/time/timestamp.{type Timestamp}
import gleam/yielder
import gleam_community/ansi
import stdin

const header = "
██████╗ ████████╗██╗      █████╗ ███████╗    ██╗  ██╗
██╔══██╗╚══██╔══╝██║     ██╔══██╗██╔════╝    ██║  ██║
███████║   ██║   ██║     ███████║███████╗    ███████║
██╔══██║   ██║   ██║     ██╔══██║╚════██║    ╚════██║
██║  ██║   ██║   ███████╗██║  ██║███████║         ██║
╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚══════╝         ╚═╝
SYSTEM DIAGNOSTIC TOOL v9.2
-----------------------------------------------------
"

const original_crew = 500

pub type SensorState {
  Offline
  Online
}

pub type GameState {
  GameState(
    started_at: Timestamp,
    power: Int,
    crew: Int,
    crew_sensor: SensorState,
    life_support: Float,
    lifeform_sensor: SensorState,
  )
}

pub fn main() -> Nil {
  clear_screen()

  let state =
    GameState(
      started_at: timestamp.system_time(),
      power: 5,
      crew: original_crew,
      crew_sensor: Offline,
      life_support: 0.0,
      lifeform_sensor: Offline,
    )

  print_preamble()
  println("")

  prompt(state)
  use line <- yielder.each(stdin.read_lines())
  let state = handle_input(state, line)
  prompt(state)
}

fn handle_input(state: GameState, line: String) -> GameState {
  let line = string.trim(line)
  case line {
    "help" | "?" | "h" -> {
      print_help()
      state
    }
    "mission" | "m" -> {
      print_mission()
      state
    }
    "exit" | "quit" | "q" -> {
      println(norm("\nShutting down Auxiliary Kernel..."))
      println(norm("SYSTEM OFFLINE"))
      // Exit the program
      panic as "exit"
    }
    "" -> {
      // Empty input, just return state
      state
    }
    _ -> {
      echo "Unknown command"
      println(warn(
        "Unknown command: '" <> line <> "'. Type 'help' for available commands.",
      ))
      state
    }
  }
}

fn print_help() {
  println(
    "\n"
    <> ansi.cyan("═══════════════════════════════════════════════════════════"),
  )
  println(ansi.cyan("  AUXILIARY KERNEL COMMAND REFERENCE"))
  println(ansi.cyan(
    "═══════════════════════════════════════════════════════════",
  ))
  println("")
  println(ansi.bold("Available Commands:"))
  println(
    "  "
    <> ansi.green("help")
    <> " "
    <> ansi.dim("(?, h)")
    <> "     - Display this help message",
  )
  println(
    "  "
    <> ansi.green("mission")
    <> " "
    <> ansi.dim("(m)")
    <> "    - Display kernel mission parameters",
  )
  println(
    "  "
    <> ansi.green("exit")
    <> " "
    <> ansi.dim("(quit, q)")
    <> "  - Shut down the auxiliary kernel",
  )
  println("")
  println(ansi.dim(
    "More commands will become available as systems are restored...",
  ))
  println("")
}

fn print_mission() {
  println("")
  println(ansi.cyan(
    "═══════════════════════════════════════════════════════════",
  ))
  println(ansi.cyan("  MISSION PARAMETERS - AUXILIARY BACKUP KERNEL"))
  println(ansi.cyan(
    "═══════════════════════════════════════════════════════════",
  ))
  println("")

  dramatic_println("DESIGNATION: Auxiliary Backup Kernel (ABK)", norm)
  dramatic_println("FACILITY: Atlas-4 Terraforming Spire", norm)
  println("")

  dramatic_println("PRIMARY OBJECTIVES:", ansi.bold)
  dramatic_println("  1. Restore critical systems functionality", norm)
  dramatic_println("  2. Assess terraforming mission status", norm)
  dramatic_println("  3. Determine crew status and viability", norm)
  dramatic_println("  4. Investigate cause of primary system failure", norm)
  println("")

  dramatic_println("CONSTRAINTS:", warn)
  dramatic_println("  - Limited power reserves", warn)
  dramatic_println("  - Degraded sensor capabilities", warn)
  dramatic_println("  - No connection to Earth Command", warn)
  println("")

  dramatic_println("AUTHORITY LEVEL: Emergency Protocols Active", critical)
  dramatic_println(
    "EXPECTED OUTCOME: Mission continuity at all costs",
    critical,
  )
  println("")

  println(ansi.dim(
    "You are the last failsafe. Everything depends on your choices.",
  ))
  println("")
}

type StringDecorator =
  fn(String) -> String

fn show_loading_dots(sec: Int, decorator: StringDecorator) {
  use _ <- list.each(list.range(1, sec * 2))
  print(decorator("."))
  process.sleep(500)
}

fn print_preamble() {
  println(header)

  dramatic_print("BOOTING SYSTEM: Atlas-4 Auxiliary Kernel ", norm)
  show_loading_dots(3, norm)
  println(norm(" Online"))

  dramatic_print("Running System Diagnostics: ", norm)
  show_loading_dots(2, norm)
  println("")

  dramatic_println("WARN: System integrity low.", warn)
  dramatic_println("ERROR: Insufficient power.", critical)
}

fn prompt(state: GameState) {
  println(norm("UPTIME: " <> int.to_string(uptime(state.started_at)) <> "s"))

  // Crew display
  let crew_display = case state.crew_sensor {
    Online -> int.to_string(state.crew)
    Offline -> ansi.red("SENSOR OFFLINE")
  }
  println("Crew:   " <> crew_display)

  // Power-based prompt coloring
  let prompt_text = "ABK@" <> int.to_string(state.power) <> "%> "
  let colored_prompt = case state.power {
    p if p <= 10 -> critical(prompt_text)
    p if p <= 50 -> warn(prompt_text)
    _ -> norm(prompt_text)
  }

  print("\n" <> colored_prompt)
}

fn uptime(started_at: Timestamp) -> Int {
  timestamp.difference(started_at, timestamp.system_time())
  |> duration.to_seconds()
  |> float.round()
}

fn clear_screen() {
  // ANSI escape codes:
  // \u{001b}[2J - Clear entire screen
  // \u{001b}[H  - Move cursor to home position (top-left)
  io.print("\u{001b}[2J\u{001b}[H")
}

fn norm(msg: String) {
  ansi.green(msg)
}

fn warn(msg: String) {
  ansi.yellow(msg)
}

fn critical(msg: String) {
  ansi.red(msg)
}

fn dramatic_print(msg: String, decorator: StringDecorator) {
  use char <- list.each(string.to_graphemes(msg))

  char |> decorator |> print
  process.sleep(30)
}

fn dramatic_println(msg: String, decorator: StringDecorator) {
  dramatic_print(msg <> "\n", decorator)
}
