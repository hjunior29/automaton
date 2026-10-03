<p align="center">
  <img src="priv/static/images/logo.png" alt="Automaton Logo" width="110" />
</p>

<h1 align="center">Automaton</h1>

<p align="center">
  <b>Interactive Cellular Automata Studio & Simulator</b>
  <br />
  Explore Conway's Game of Life, Wolfram 1D Elementary Automata, and complex emergent behavior in real time.
</p>

<p align="center">
  <a href="https://auto-maton.fly.dev">
    <img src="https://img.shields.io/badge/Demo-auto--maton.fly.dev-6366f1?style=for-the-badge&logo=flydotio&logoColor=white" alt="Live Demo" />
  </a>
  <img src="https://img.shields.io/badge/Elixir-1.18-4B275F?style=for-the-badge&logo=elixir&logoColor=white" alt="Elixir" />
  <img src="https://img.shields.io/badge/Phoenix-LiveView%201.1-FD4F00?style=for-the-badge&logo=phoenixframework&logoColor=white" alt="Phoenix LiveView" />
  <img src="https://img.shields.io/badge/Tailwind-CSS-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white" alt="Tailwind CSS" />
  <img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge" alt="License" />
</p>

<p align="center">
  <a href="https://auto-maton.fly.dev"><strong>🌐 Experimente a demonstração ao vivo &rarr;</strong></a>
</p>

---

## 🌟 Visão Geral / Overview

**Automaton** é um laboratório interativo para explorar a teoria e a beleza computacional dos **autômatos celulares**. Construído com **Elixir** e **Phoenix LiveView**, todas as simulações e renderizações acontecem de forma reativa e concorrente no servidor com baixíssima latência, sem sobrecarregar o cliente.

Tanto entusiastas quanto estudantes de ciência da computação e matemática podem observar como regras simples locais dão origem a comportamentos caóticos, periódicos ou com capacidade computacional universal (emergência).

---

## ✨ Funcionalidades Principais

### 1. Conway's Game of Life (2D)
- **Grade Interativa:** Desenhe e apague células vivas em tempo real com o mouse.
- **Topologia Toroidal:** Opção de bordas conectadas (toro circular) ou finitas.
- **Biblioteca de Presets:** Carregue estruturas clássicas com um clique:
  - *Naves (Spaceships):* Glider, Lightweight Spaceship (LWSS).
  - *Osciladores:* Blinker, Toad, Beacon, Pulsar, Pentadecathlon.
  - *Geradores:* Gosper Glider Gun (disparo contínuo de gliders).
  - *Matusaléns:* Acorn, R-pentomino, Diehard.
- **Controle de Execução:** Play, pause, avanço passo-a-passo, velocidade regulável e gerador aleatório com controle de densidade.
- **Estatísticas ao Vivo:** Contador de gerações e contagem dinâmica de células vivas.

### 2. Wolfram Elementary Automata (1D)
- **Todas as 256 Regras de Wolfram:** Experimente do Rule 0 ao Rule 255.
- **Decodificador Visual de Vizinhança:** Tabela de transição de bits interativa mostrando a correspondência binária dos 8 padrões (`111` até `000`).
- **Estado Inicial:** Célula única no centro (padrões fractais puros) ou semente aleatória.
- **Evolução Espaço-Temporal:** Visualização do histórico cascateado linha por linha.

### 3. História, Conceitos & Teoria
- **Linha do Tempo:** Das origens com John von Neumann e Stanislaw Ulam nos anos 1940, passando pela popularização com John Conway em 1970, até os estudos fundamentais de Stephen Wolfram em *A New Kind of Science*.
- **As 4 Classes de Wolfram:** Exemplos e explicações didáticas de comportamentos Homogêneos (Classe 1), Periódicos (Classe 2), Caóticos (Classe 3) e Complexos/Computacionais (Classe 4).

### 4. Internacionalização (i18n)
- Suporte nativo completo em **Português** e **Inglês** com persistência de preferências de idioma.

---

## 🔬 Referência Rápida de Regras Notáveis

| Regra / Modelo | Dimensão | Classe de Wolfram | Propriedade Notável |
| :--- | :---: | :---: | :--- |
| **Game of Life** | 2D | Classe 4 | Turing-completo; vida artificial e emergência complexa. |
| **Rule 30** | 1D | Classe 3 | Caótico e pseudo-aleatório (usado para geração de números aleatórios). |
| **Rule 90** | 1D | Classe 2 | Gera o triângulo de Sierpiński (geometria fractal). |
| **Rule 110** | 1D | Classe 4 | Provado formalmente como Turing-completo (suporta computação universal). |
| **Rule 184** | 1D | Classe 2 | Modelo matemático para fluxo de tráfego e sedimentação de partículas. |

---

## 🛠️ Stack Tecnológica

- **Linguagem:** [Elixir 1.18](https://elixir-lang.org/)
- **Framework Web:** [Phoenix Framework 1.8](https://www.phoenixframework.org/)
- **Tempo Real & UI:** [Phoenix LiveView 1.1](https://hexdocs.pm/phoenix_live_view/)
- **Servidor HTTP:** [Bandit 1.5](https://github.com/mtrudel/bandit) (servidor web em Elixir nativo de alta performance)
- **Estilização:** [Tailwind CSS](https://tailwindcss.com/) & [daisyUI](https://daisyui.com/)
- **Ícones:** [Heroicons](https://heroicons.com/)
- **Infraestrutura:** Docker & [Fly.io](https://fly.io) com auto-stop e auto-start sob demanda.

---

## 🚀 Como Executar Localmente

### Pré-requisitos
- Elixir 1.15 ou superior e Erlang/OTP 26+
- Node.js (opcional, gerenciado pelos wrappers do esbuild/tailwind)

### Passo a Passo

```bash
# 1. Clone o repositório
git clone https://github.com/hjunior29/automaton.git
cd automaton

# 2. Instale as dependências e compile os assets
mix setup

# 3. Inicie o servidor Phoenix
mix phx.server
```

Acesse [`http://localhost:4000`](http://localhost:4000) no seu navegador.

Para rodar com o console interativo IEx:
```bash
iex -S mix phx.server
```

Para rodar os testes e checagens de formato:
```bash
mix test
mix format --check-formatted
```

---

## ☁️ Deploy no Fly.io

O projeto está configurado para deploy em contêiner otimizado no Fly.io:

```bash
# Deploy remoto (compilado via remote builder)
fly deploy --remote-only
```

A configuração em [`fly.toml`](fly.toml) utiliza `auto_stop_machines = "stop"` e `auto_start_machines = true`, suspendendo a máquina quando ociosa e acordando instantaneamente na primeira requisição HTTP.

---

<p align="center">
  Desenvolvido por <a href="https://github.com/hjunior29">Helder Lima (@hjunior29)</a>
</p>
