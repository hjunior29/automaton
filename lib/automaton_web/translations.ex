defmodule AutomatonWeb.Translations do
  @moduledoc "Simple i18n translations for EN and PT."

  @translations %{
    "en" => %{
      # Navigation
      nav_home: "Home",
      nav_history: "History",
      nav_simulator: "Game of Life",
      nav_elementary: "Elementary CA",
      language_label: "PT",

      # Home page
      hero_title: "Automaton",
      hero_subtitle:
        "Explore the fascinating world of discrete computational models where simple rules create extraordinary complexity.",
      hero_cta_simulator: "Try the Simulator",
      hero_cta_history: "Learn the History",

      home_what_title: "What is a Cellular Automaton?",
      home_what_text:
        "A cellular automaton is a discrete model of computation consisting of a regular grid of cells, each in one of a finite number of states. A set of simple rules determines how each cell evolves based on its neighbors. Despite their simplicity, cellular automata can produce remarkably complex and beautiful patterns.",

      home_feature_1_title: "Rich History",
      home_feature_1_desc:
        "From Von Neumann's self-replicating machines in the 1940s to Wolfram's classification in the 1980s.",
      home_feature_2_title: "Game of Life",
      home_feature_2_desc:
        "Conway's iconic 2D automaton where cells live, die, and reproduce following just four rules.",
      home_feature_3_title: "Elementary CA",
      home_feature_3_desc:
        "Wolfram's 256 one-dimensional rules that range from simple patterns to Turing-complete computation.",

      home_concepts_title: "Key Concepts",
      home_concept_cell: "Cell",
      home_concept_cell_desc: "The fundamental unit. Each cell has a finite number of possible states (e.g., alive or dead).",
      home_concept_neighborhood: "Neighborhood",
      home_concept_neighborhood_desc: "The set of adjacent cells that influence a cell's next state. Common types: Von Neumann (4 cells) and Moore (8 cells).",
      home_concept_rules: "Rules",
      home_concept_rules_desc: "A function that determines the next state of each cell based on its current state and its neighbors' states.",
      home_concept_generation: "Generation",
      home_concept_generation_desc: "Each step in time where all cells are updated simultaneously according to the rules.",

      # History page
      history_title: "The History of Cellular Automata",
      history_subtitle: "A journey from mathematical curiosity to computational universe",

      history_1940s_title: "The Origins",
      history_1940s_decade: "1940s",
      history_1940s_text:
        "The concept was originally conceived at Los Alamos National Laboratory. Stanislaw Ulam studied crystal growth using a simple lattice network, while John von Neumann worked on self-replicating systems. Von Neumann's initial \"kinematic model\" envisioned one robot building another, but the complexity of providing a \"sea of parts\" led Ulam to suggest using a discrete system instead. Together, they created the first cellular automata — a method for calculating liquid motion by treating it as a group of discrete units.",
      history_1940s_quote: "\"The general and logical theory of automata\" — John von Neumann, Hixon Symposium, 1948",

      history_vn_title: "Von Neumann's Universal Constructor",
      history_vn_decade: "1950s",
      history_vn_text:
        "Von Neumann designed a two-dimensional cellular automaton with 29 states per cell that could achieve self-replication. He proved that a configuration of roughly 200,000 cells could make endless copies of itself — a universal copier and constructor. This tessellation model, known as the Von Neumann universal constructor, demonstrated that self-reproduction was theoretically possible in a computational system.",

      history_1960s_title: "Mathematical Foundations",
      history_1960s_decade: "1960s",
      history_1960s_text:
        "Cellular automata were studied as dynamical systems, and the connection with symbolic dynamics was established. Gustav Hedlund's 1969 paper provided the foundational Curtis-Hedlund-Lyndon theorem. That same year, Konrad Zuse published \"Calculating Space,\" proposing that the universe itself is the output of a deterministic computation on a cellular automaton — founding the field of digital physics. Alvy Ray Smith completed the first comprehensive mathematical treatment of CA as a general class of computers.",

      history_gol_title: "Conway's Game of Life",
      history_gol_decade: "1970",
      history_gol_text:
        "John Conway invented a two-state, two-dimensional cellular automaton that became widely known as the Game of Life. Popularized by Martin Gardner in Scientific American, it follows four simple rules governing birth, survival, and death. Despite its simplicity, it achieves an impressive diversity of behavior — including gliders that move across the grid and structures complex enough to emulate a universal Turing machine.",
      history_gol_rules_title: "The Four Rules",
      history_gol_rule_1: "Any live cell with fewer than two live neighbours dies (underpopulation).",
      history_gol_rule_2: "Any live cell with two or three live neighbours lives on.",
      history_gol_rule_3: "Any live cell with more than three live neighbours dies (overpopulation).",
      history_gol_rule_4: "Any dead cell with exactly three live neighbours becomes alive (reproduction).",

      history_wolfram_title: "Wolfram's Revolution",
      history_wolfram_decade: "1983",
      history_wolfram_text:
        "Stephen Wolfram began a systematic study of one-dimensional cellular automata, which he called elementary cellular automata. His investigations of Rule 30 revealed unexpected complexity from simple rules, leading him to suspect that complexity in nature may arise from similar mechanisms. He formulated the concepts of intrinsic randomness and computational irreducibility, and his research assistant Matthew Cook later proved that Rule 110 is Turing-complete.",

      history_classes_title: "Wolfram's Four Classes",
      history_class_1: "Class 1 — Patterns evolve into a stable, homogeneous state. Randomness disappears.",
      history_class_2: "Class 2 — Patterns evolve into stable or oscillating structures. Local changes stay local.",
      history_class_3: "Class 3 — Patterns evolve chaotically. Stable structures are destroyed by noise.",
      history_class_4: "Class 4 — Complex interacting structures emerge. Capable of universal computation.",

      history_applications_title: "Applications Across Science",
      history_applications_text:
        "Cellular automata have found applications across many fields. In biology, seashell patterns of the genus Conus resemble Wolfram's Rule 30. In physics, lattice gas automata simulate fluid dynamics, and the Ising model studies phase transitions. In chemistry, they model the Belousov-Zhabotinsky reaction's geometric patterns. In computer science, they've been used for cryptography, error-correcting codes, procedural generation, and generative music.",

      history_app_biology: "Biology",
      history_app_biology_desc: "Seashell patterns, plant gas regulation, neural network simulation, cancer invasion modeling.",
      history_app_physics: "Physics",
      history_app_physics_desc: "Fluid dynamics, phase transitions, crystal growth simulation, digital physics.",
      history_app_cs: "Computer Science",
      history_app_cs_desc: "Cryptography, error-correcting codes, pseudorandom number generation, Turing machines.",
      history_app_art: "Art & Music",
      history_app_art_desc: "Generative music composition, procedural terrain generation, maze algorithms.",

      # Simulator page
      sim_title: "Game of Life Simulator",
      sim_description: "Click on the grid to toggle cells, then press play to watch the evolution.",
      sim_play: "Play",
      sim_pause: "Pause",
      sim_step: "Step",
      sim_clear: "Clear",
      sim_random: "Random",
      sim_speed: "Speed",
      sim_speed_slow: "Slow",
      sim_speed_fast: "Fast",
      sim_generation: "Generation",
      sim_population: "Population",
      sim_grid_size: "Grid Size",
      sim_preset: "Patterns",
      sim_preset_select: "Choose a pattern...",
      sim_rows: "Rows",
      sim_cols: "Columns",
      sim_controls: "Controls",
      sim_stats: "Stats",
      sim_boundary: "Boundary",
      sim_wrap_toroidal: "Toroidal (wrapping)",
      sim_wrap_bounded: "Bounded (finite)",

      # Elementary CA page
      elem_title: "Elementary Cellular Automata",
      elem_description:
        "Explore Wolfram's 256 one-dimensional rules. Each rule defines how a cell's state changes based on itself and its two neighbors.",
      elem_rule: "Rule",
      elem_generate: "Generate",
      elem_clear: "Clear",
      elem_width: "Width",
      elem_generations: "Generations",
      elem_initial: "Initial State",
      elem_initial_single: "Single Cell",
      elem_initial_random: "Random",
      elem_rule_table: "Rule Table",
      elem_presets: "Notable Rules",
      elem_rule_30: "Rule 30 — Chaotic (Class 3)",
      elem_rule_90: "Rule 90 — Sierpinski Triangle",
      elem_rule_110: "Rule 110 — Turing Complete (Class 4)",
      elem_rule_184: "Rule 184 — Traffic Model",
      elem_rule_0: "Rule 0 — All Die",
      elem_rule_255: "Rule 255 — All Live",

      # Footer
      footer_source: "Source: Wikipedia — Cellular Automaton",
      footer_built_with: "Built with Phoenix LiveView by",
      footer_project_name: "Automaton"
    },
    "pt" => %{
      # Navigation
      nav_home: "Início",
      nav_history: "História",
      nav_simulator: "Jogo da Vida",
      nav_elementary: "AC Elementar",
      language_label: "EN",

      # Home page
      hero_title: "Autômatos Celulares",
      hero_subtitle:
        "Explore o fascinante mundo dos modelos computacionais discretos onde regras simples criam complexidade extraordinária.",
      hero_cta_simulator: "Experimentar o Simulador",
      hero_cta_history: "Conhecer a História",

      home_what_title: "O que é um Autômato Celular?",
      home_what_text:
        "Um autômato celular é um modelo discreto de computação que consiste em uma grade regular de células, cada uma em um de um número finito de estados. Um conjunto de regras simples determina como cada célula evolui com base em seus vizinhos. Apesar de sua simplicidade, autômatos celulares podem produzir padrões notavelmente complexos e bonitos.",

      home_feature_1_title: "História Rica",
      home_feature_1_desc:
        "Das máquinas auto-replicantes de Von Neumann nos anos 1940 à classificação de Wolfram nos anos 1980.",
      home_feature_2_title: "Jogo da Vida",
      home_feature_2_desc:
        "O icônico autômato 2D de Conway onde células vivem, morrem e se reproduzem seguindo apenas quatro regras.",
      home_feature_3_title: "AC Elementar",
      home_feature_3_desc:
        "As 256 regras unidimensionais de Wolfram que vão de padrões simples à computação Turing-completa.",

      home_concepts_title: "Conceitos Fundamentais",
      home_concept_cell: "Célula",
      home_concept_cell_desc: "A unidade fundamental. Cada célula tem um número finito de estados possíveis (ex: viva ou morta).",
      home_concept_neighborhood: "Vizinhança",
      home_concept_neighborhood_desc: "O conjunto de células adjacentes que influenciam o próximo estado de uma célula. Tipos comuns: Von Neumann (4 células) e Moore (8 células).",
      home_concept_rules: "Regras",
      home_concept_rules_desc: "Uma função que determina o próximo estado de cada célula com base em seu estado atual e nos estados de seus vizinhos.",
      home_concept_generation: "Geração",
      home_concept_generation_desc: "Cada passo no tempo onde todas as células são atualizadas simultaneamente de acordo com as regras.",

      # History page
      history_title: "A História dos Autômatos Celulares",
      history_subtitle: "Uma jornada da curiosidade matemática ao universo computacional",

      history_1940s_title: "As Origens",
      history_1940s_decade: "1940",
      history_1940s_text:
        "O conceito foi originalmente concebido no Laboratório Nacional de Los Alamos. Stanislaw Ulam estudou o crescimento de cristais usando uma rede de treliça simples, enquanto John von Neumann trabalhava em sistemas auto-replicantes. O modelo \"cinemático\" inicial de Von Neumann imaginava um robô construindo outro, mas a complexidade de fornecer um \"mar de peças\" levou Ulam a sugerir o uso de um sistema discreto. Juntos, eles criaram os primeiros autômatos celulares — um método para calcular o movimento de líquidos tratando-os como um grupo de unidades discretas.",
      history_1940s_quote: "\"A teoria geral e lógica dos autômatos\" — John von Neumann, Simpósio Hixon, 1948",

      history_vn_title: "O Construtor Universal de Von Neumann",
      history_vn_decade: "1950",
      history_vn_text:
        "Von Neumann projetou um autômato celular bidimensional com 29 estados por célula que poderia alcançar auto-replicação. Ele provou que uma configuração de aproximadamente 200.000 células poderia fazer cópias infinitas de si mesma — um copiador e construtor universal. Este modelo de tesselação, conhecido como construtor universal de Von Neumann, demonstrou que a auto-reprodução era teoricamente possível em um sistema computacional.",

      history_1960s_title: "Fundamentos Matemáticos",
      history_1960s_decade: "1960",
      history_1960s_text:
        "Os autômatos celulares foram estudados como sistemas dinâmicos, e a conexão com a dinâmica simbólica foi estabelecida. O artigo de Gustav Hedlund de 1969 forneceu o fundamental teorema de Curtis-Hedlund-Lyndon. No mesmo ano, Konrad Zuse publicou \"Calculating Space\", propondo que o universo é o resultado de uma computação determinística em um autômato celular — fundando o campo da física digital. Alvy Ray Smith completou o primeiro tratamento matemático abrangente dos ACs como uma classe geral de computadores.",

      history_gol_title: "Jogo da Vida de Conway",
      history_gol_decade: "1970",
      history_gol_text:
        "John Conway inventou um autômato celular bidimensional de dois estados que se tornou amplamente conhecido como Jogo da Vida. Popularizado por Martin Gardner na Scientific American, segue quatro regras simples que governam nascimento, sobrevivência e morte. Apesar de sua simplicidade, alcança uma diversidade impressionante de comportamento — incluindo gliders que se movem pela grade e estruturas complexas o suficiente para emular uma máquina de Turing universal.",
      history_gol_rules_title: "As Quatro Regras",
      history_gol_rule_1: "Qualquer célula viva com menos de dois vizinhos vivos morre (subpopulação).",
      history_gol_rule_2: "Qualquer célula viva com dois ou três vizinhos vivos sobrevive.",
      history_gol_rule_3: "Qualquer célula viva com mais de três vizinhos vivos morre (superpopulação).",
      history_gol_rule_4: "Qualquer célula morta com exatamente três vizinhos vivos torna-se viva (reprodução).",

      history_wolfram_title: "A Revolução de Wolfram",
      history_wolfram_decade: "1983",
      history_wolfram_text:
        "Stephen Wolfram iniciou um estudo sistemático de autômatos celulares unidimensionais, que ele chamou de autômatos celulares elementares. Suas investigações da Regra 30 revelaram complexidade inesperada a partir de regras simples, levando-o a suspeitar que a complexidade na natureza pode surgir de mecanismos semelhantes. Ele formulou os conceitos de aleatoriedade intrínseca e irredutibilidade computacional, e seu assistente de pesquisa Matthew Cook provou posteriormente que a Regra 110 é Turing-completa.",

      history_classes_title: "As Quatro Classes de Wolfram",
      history_class_1: "Classe 1 — Padrões evoluem para um estado estável e homogêneo. A aleatoriedade desaparece.",
      history_class_2: "Classe 2 — Padrões evoluem para estruturas estáveis ou oscilantes. Mudanças locais permanecem locais.",
      history_class_3: "Classe 3 — Padrões evoluem caoticamente. Estruturas estáveis são destruídas pelo ruído.",
      history_class_4: "Classe 4 — Estruturas complexas interativas emergem. Capaz de computação universal.",

      history_applications_title: "Aplicações Através da Ciência",
      history_applications_text:
        "Os autômatos celulares encontraram aplicações em muitos campos. Na biologia, padrões de conchas do gênero Conus se assemelham à Regra 30 de Wolfram. Na física, autômatos de gás de treliça simulam dinâmica de fluidos, e o modelo de Ising estuda transições de fase. Na química, modelam os padrões geométricos da reação de Belousov-Zhabotinsky. Na ciência da computação, foram usados para criptografia, códigos de correção de erros, geração procedural e música generativa.",

      history_app_biology: "Biologia",
      history_app_biology_desc: "Padrões de conchas, regulação gasosa de plantas, simulação de redes neurais, modelagem de invasão de câncer.",
      history_app_physics: "Física",
      history_app_physics_desc: "Dinâmica de fluidos, transições de fase, simulação de crescimento de cristais, física digital.",
      history_app_cs: "Ciência da Computação",
      history_app_cs_desc: "Criptografia, códigos de correção de erros, geração de números pseudoaleatórios, máquinas de Turing.",
      history_app_art: "Arte & Música",
      history_app_art_desc: "Composição musical generativa, geração procedural de terreno, algoritmos de labirintos.",

      # Simulator page
      sim_title: "Simulador Jogo da Vida",
      sim_description: "Clique na grade para alternar células, depois pressione play para observar a evolução.",
      sim_play: "Play",
      sim_pause: "Pausar",
      sim_step: "Passo",
      sim_clear: "Limpar",
      sim_random: "Aleatório",
      sim_speed: "Velocidade",
      sim_speed_slow: "Lento",
      sim_speed_fast: "Rápido",
      sim_generation: "Geração",
      sim_population: "População",
      sim_grid_size: "Tamanho da Grade",
      sim_preset: "Padrões",
      sim_preset_select: "Escolha um padrão...",
      sim_rows: "Linhas",
      sim_cols: "Colunas",
      sim_controls: "Controles",
      sim_stats: "Estatísticas",
      sim_boundary: "Fronteira",
      sim_wrap_toroidal: "Toroidal (contínuo)",
      sim_wrap_bounded: "Limitado (finito)",

      # Elementary CA page
      elem_title: "Autômatos Celulares Elementares",
      elem_description:
        "Explore as 256 regras unidimensionais de Wolfram. Cada regra define como o estado de uma célula muda com base nela mesma e em seus dois vizinhos.",
      elem_rule: "Regra",
      elem_generate: "Gerar",
      elem_clear: "Limpar",
      elem_width: "Largura",
      elem_generations: "Gerações",
      elem_initial: "Estado Inicial",
      elem_initial_single: "Célula Única",
      elem_initial_random: "Aleatório",
      elem_rule_table: "Tabela de Regras",
      elem_presets: "Regras Notáveis",
      elem_rule_30: "Regra 30 — Caótica (Classe 3)",
      elem_rule_90: "Regra 90 — Triângulo de Sierpinski",
      elem_rule_110: "Regra 110 — Turing Completa (Classe 4)",
      elem_rule_184: "Regra 184 — Modelo de Tráfego",
      elem_rule_0: "Regra 0 — Todas Morrem",
      elem_rule_255: "Regra 255 — Todas Vivem",

      # Footer
      footer_source: "Fonte: Wikipédia — Autômato Celular",
      footer_built_with: "Feito com Phoenix LiveView por",
      footer_project_name: "Autômatos"
    }
  }

  def t(locale, key) when is_atom(key) do
    get_in(@translations, [locale, key]) ||
      get_in(@translations, ["en", key]) ||
      to_string(key)
  end

  def t(locale, key) when is_binary(key) do
    t(locale, String.to_existing_atom(key))
  rescue
    _ -> key
  end

  def other_locale("en"), do: "pt"
  def other_locale("pt"), do: "en"
  def other_locale(_), do: "en"
end
