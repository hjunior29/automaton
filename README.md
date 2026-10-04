<p align="center">
  <img src="priv/static/images/logo.png" alt="Automaton Logo" width="110" />
</p>

<h1 align="center">Automaton</h1>

<p align="center">
  <b>Interactive Cellular Automata Studio</b>
  <br />
  Explore Conway's Game of Life in real time and learn the history and theory of cellular automata.
</p>

<p align="center">
  <a href="https://auto-maton.fly.dev">
    <img src="https://img.shields.io/badge/Demo-auto--maton.fly.dev-6366f1?style=for-the-badge&logo=flydotio&logoColor=white" alt="Live Demo" />
  </a>
  <img src="https://img.shields.io/badge/Elixir-1.18-4B275F?style=for-the-badge&logo=elixir&logoColor=white" alt="Elixir" />
  <img src="https://img.shields.io/badge/Phoenix-LiveView%201.1-FD4F00?style=for-the-badge&logo=phoenixframework&logoColor=white" alt="Phoenix LiveView" />
  <img src="https://img.shields.io/badge/Tailwind-CSS-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white" alt="Tailwind CSS" />
</p>

<p align="center">
  <a href="https://auto-maton.fly.dev"><strong>🌐 Try the live demo &rarr;</strong></a>
</p>

---

## 🌟 Overview

**Automaton** is an interactive lab for exploring **cellular automata**: systems where a grid of cells evolves step by step following simple local rules, often producing surprisingly complex behavior. It is built with **Elixir** and **Phoenix LiveView**: the simulation runs on the server and each new generation is pushed to an HTML5 Canvas in the browser.

The app has three pages:

| Page | Route | What you'll find |
| :--- | :--- | :--- |
| **Home** | `/` | What a cellular automaton is and its key concepts: cell, neighborhood, rules and generation. |
| **History** | `/history` | A timeline from Ulam and von Neumann to Conway and Wolfram, plus real-world applications. |
| **Game of Life** | `/simulator` | The interactive Conway's Game of Life simulator. |

---

## ✨ Features

### 1. Conway's Game of Life Simulator
- **Interactive grid:** click or drag (mouse or touch) to toggle cells on a 50 × 65 grid.
- **Pattern library** with one-click presets:
  - *Spaceship:* Glider
  - *Oscillators:* Blinker, Toad, Beacon, Pulsar
  - *Gun:* Gosper Glider Gun (emits gliders forever)
  - *Methuselah:* R-pentomino
- **Playback controls:** play, pause, single step, clear and random fill.
- **Speed control:** slider from slow to fast.
- **Boundary mode:** toroidal (edges wrap around) or bounded (finite grid).
- **Live stats:** population chart over the last 200 generations, showing the current generation and population.

### 2. History & Concepts
- **Key concepts:** cell, neighborhood (von Neumann and Moore), rules and generation.
- **Timeline:** Stanislaw Ulam and John von Neumann in the 1940s, von Neumann's universal constructor, the mathematical foundations of the 1960s, Conway's Game of Life (1970) and its four rules, and Stephen Wolfram's study of elementary cellular automata.
- **Wolfram's four classes:** homogeneous, periodic, chaotic and complex behavior.
- **Applications:** physics, biology, computer science, and art & music (generative music, procedural terrain and mazes).

### 3. Bilingual Interface & Themes
- Full **English** and **Portuguese** support, with the selected language stored in the session.
- **Light, dark and system** themes.

---

## ⚙️ How It Works

- **Server-side simulation:** each generation is computed in Elixir inside the LiveView process. A tick loop (`Process.send_after`) advances the simulation at the selected speed.
- **Sparse grid:** the grid is a `MapSet` of live cells, so each step only processes the neighborhoods of living cells instead of scanning the whole grid (`lib/automaton/game_of_life.ex`).
- **Canvas rendering:** the server sends the live cells and population with `push_event`, and JavaScript hooks draw the grid and the population chart on HTML5 Canvas (`assets/js/hooks/`).

---

## 🛠️ Tech Stack

- **Language:** [Elixir 1.18](https://elixir-lang.org/) / Erlang OTP 28
- **Web framework:** [Phoenix Framework 1.8](https://www.phoenixframework.org/)
- **Real-time UI:** [Phoenix LiveView 1.1](https://hexdocs.pm/phoenix_live_view/)
- **HTTP server:** [Bandit](https://github.com/mtrudel/bandit)
- **Rendering:** HTML5 Canvas through LiveView JavaScript hooks
- **Styling:** [Tailwind CSS](https://tailwindcss.com/) & [daisyUI](https://daisyui.com/), with [Heroicons](https://heroicons.com/)
- **Infrastructure:** Docker & [Fly.io](https://fly.io) with on-demand auto-stop and auto-start

---

## 🚀 Running Locally

### Prerequisites
- Elixir 1.15+ and Erlang/OTP 26+

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/hjunior29/automaton.git
cd automaton

# 2. Install dependencies and build assets
mix setup

# 3. Start the Phoenix server
mix phx.server
```

Open [`http://localhost:4000`](http://localhost:4000) in your browser.

To run with the interactive IEx console:
```bash
iex -S mix phx.server
```

To run the tests and check formatting:
```bash
mix test
mix format --check-formatted
```

---

## ☁️ Deploying to Fly.io

The project ships with a Dockerfile and a Fly.io configuration:

```bash
# Remote build and deploy
fly deploy --remote-only
```

[`fly.toml`](fly.toml) sets `auto_stop_machines = "stop"` and `auto_start_machines = true`, so the machine stops when idle and starts again on the next HTTP request.

---

## 🗺️ Roadmap

- **Elementary (1D) cellular automata:** the engine for Wolfram's 256 elementary rules already exists in `lib/automaton/elementary_ca.ex`, but its page is not available in the app yet.

---

<p align="center">
  Built by <a href="https://github.com/hjunior29">Helder Lima (@hjunior29)</a>
</p>
