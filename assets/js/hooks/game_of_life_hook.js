const GameOfLifeHook = {
  mounted() {
    this.canvas = this.el
    this.ctx = this.canvas.getContext('2d')
    this.cells = new Set()
    this.rows = parseInt(this.el.dataset.rows) || 45
    this.cols = parseInt(this.el.dataset.cols) || 70
    this.isDragging = false
    this.dragMode = null
    this.lastToggled = null

    // Classic clean look
    this.bgColor = '#d4d4d8'
    this.gridColor = '#b4b4bb'
    this.cellColor = '#18181b'
    this.borderColor = '#71717a'

    // Wait a frame so container has its final layout dimensions
    requestAnimationFrame(() => {
      this.resizeCanvas()

      this.resizeHandler = () => this.resizeCanvas()
      window.addEventListener('resize', this.resizeHandler)
    })

    // Mouse events
    this.canvas.addEventListener('mousedown', (e) => this.onMouseDown(e))
    this.canvas.addEventListener('mousemove', (e) => this.onMouseMove(e))
    this.mouseUpHandler = () => { this.isDragging = false; this.lastToggled = null }
    window.addEventListener('mouseup', this.mouseUpHandler)

    // Touch events
    this.canvas.addEventListener('touchstart', (e) => this.onTouchStart(e), { passive: false })
    this.canvas.addEventListener('touchmove', (e) => this.onTouchMove(e), { passive: false })
    this.canvas.addEventListener('touchend', () => { this.isDragging = false; this.lastToggled = null })

    // LiveView events
    this.handleEvent("update_grid", ({ cells }) => {
      this.cells = new Set(cells.map(([r, c]) => `${r},${c}`))
      this.draw()
    })

    this.handleEvent("update_size", ({ rows, cols }) => {
      this.rows = rows
      this.cols = cols
      this.resizeCanvas()
    })
  },

  resizeCanvas() {
    const container = this.canvas.parentElement
    const availableWidth = container.clientWidth

    // Cell size based on available width, filling it completely
    this.cellSize = Math.floor(availableWidth / this.cols)
    this.cellSize = Math.max(6, Math.min(this.cellSize, 20))

    const canvasW = this.cols * this.cellSize + 1
    const canvasH = this.rows * this.cellSize + 1

    this.canvas.width = canvasW
    this.canvas.height = canvasH
    this.canvas.style.width = canvasW + 'px'
    this.canvas.style.height = canvasH + 'px'

    this.draw()
  },

  getCellFromXY(x, y) {
    // Account for CSS scaling if any
    const rect = this.canvas.getBoundingClientRect()
    const scaleX = this.canvas.width / rect.width
    const scaleY = this.canvas.height / rect.height
    const cx = x * scaleX
    const cy = y * scaleY

    return {
      row: Math.max(0, Math.min(Math.floor(cy / this.cellSize), this.rows - 1)),
      col: Math.max(0, Math.min(Math.floor(cx / this.cellSize), this.cols - 1))
    }
  },

  toggleCell(row, col) {
    const key = `${row},${col}`
    if (this.dragMode === 'add') {
      this.cells.add(key)
    } else {
      this.cells.delete(key)
    }
    this.draw()
    this.pushEvent('toggle_cell', { row, col })
  },

  onMouseDown(e) {
    e.preventDefault()
    const rect = this.canvas.getBoundingClientRect()
    const { row, col } = this.getCellFromXY(e.clientX - rect.left, e.clientY - rect.top)
    const key = `${row},${col}`
    this.isDragging = true
    this.dragMode = this.cells.has(key) ? 'remove' : 'add'
    this.lastToggled = key
    this.toggleCell(row, col)
  },

  onMouseMove(e) {
    if (!this.isDragging) return
    e.preventDefault()
    const rect = this.canvas.getBoundingClientRect()
    const { row, col } = this.getCellFromXY(e.clientX - rect.left, e.clientY - rect.top)
    const key = `${row},${col}`
    if (key === this.lastToggled) return
    this.lastToggled = key
    const isAlive = this.cells.has(key)
    if ((this.dragMode === 'add' && !isAlive) || (this.dragMode === 'remove' && isAlive)) {
      this.toggleCell(row, col)
    }
  },

  onTouchStart(e) {
    e.preventDefault()
    const touch = e.touches[0]
    const rect = this.canvas.getBoundingClientRect()
    const { row, col } = this.getCellFromXY(touch.clientX - rect.left, touch.clientY - rect.top)
    const key = `${row},${col}`
    this.isDragging = true
    this.dragMode = this.cells.has(key) ? 'remove' : 'add'
    this.lastToggled = key
    this.toggleCell(row, col)
  },

  onTouchMove(e) {
    if (!this.isDragging) return
    e.preventDefault()
    const touch = e.touches[0]
    const rect = this.canvas.getBoundingClientRect()
    const { row, col } = this.getCellFromXY(touch.clientX - rect.left, touch.clientY - rect.top)
    const key = `${row},${col}`
    if (key === this.lastToggled) return
    this.lastToggled = key
    const isAlive = this.cells.has(key)
    if ((this.dragMode === 'add' && !isAlive) || (this.dragMode === 'remove' && isAlive)) {
      this.toggleCell(row, col)
    }
  },

  draw() {
    const ctx = this.ctx
    const { cellSize, rows, cols } = this
    const w = cols * cellSize
    const h = rows * cellSize

    // Light gray background
    ctx.fillStyle = this.bgColor
    ctx.fillRect(0, 0, w + 1, h + 1)

    // Grid lines
    ctx.strokeStyle = this.gridColor
    ctx.lineWidth = 0.5
    for (let x = 0; x <= w; x += cellSize) {
      ctx.beginPath()
      ctx.moveTo(x + 0.5, 0)
      ctx.lineTo(x + 0.5, h)
      ctx.stroke()
    }
    for (let y = 0; y <= h; y += cellSize) {
      ctx.beginPath()
      ctx.moveTo(0, y + 0.5)
      ctx.lineTo(w, y + 0.5)
      ctx.stroke()
    }

    // Alive cells - solid dark fill
    ctx.fillStyle = this.cellColor
    for (const key of this.cells) {
      const [r, c] = key.split(',').map(Number)
      ctx.fillRect(c * cellSize + 1, r * cellSize + 1, cellSize - 1, cellSize - 1)
    }

    // Outer border
    ctx.strokeStyle = this.borderColor
    ctx.lineWidth = 1
    ctx.strokeRect(0.5, 0.5, w, h)
  },

  destroyed() {
    window.removeEventListener('resize', this.resizeHandler)
    window.removeEventListener('mouseup', this.mouseUpHandler)
  }
}

export default GameOfLifeHook
