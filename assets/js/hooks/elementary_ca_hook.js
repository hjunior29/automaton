const ElementaryCAHook = {
  mounted() {
    this.canvas = this.el
    this.ctx = this.canvas.getContext('2d')
    this.lastData = null

    this.updateColors()

    this.themeObserver = new MutationObserver(() => {
      this.updateColors()
      if (this.lastData) this.renderCA(this.lastData.rows, this.lastData.width)
    })
    this.themeObserver.observe(document.documentElement, {
      attributes: true,
      attributeFilter: ['data-theme']
    })

    requestAnimationFrame(() => {
      this.resizeHandler = () => {
        if (this.lastData) this.renderCA(this.lastData.rows, this.lastData.width)
      }
      window.addEventListener('resize', this.resizeHandler)
    })

    this.handleEvent("render_ca", ({ rows, width }) => {
      this.lastData = { rows, width }
      this.renderCA(rows, width)
    })
  },

  updateColors() {
    const theme = document.documentElement.getAttribute('data-theme')
    const isDark = theme === 'dark' ||
      (!theme && window.matchMedia('(prefers-color-scheme: dark)').matches)

    this.bgColor = isDark ? '#1d232a' : '#f5f5f5'
    this.isDark = isDark
  },

  renderCA(rows, width) {
    const container = this.canvas.parentElement
    const maxWidth = container.clientWidth

    if (!rows.length) {
      this.canvas.width = maxWidth
      this.canvas.height = 200
      this.canvas.style.width = '100%'
      this.ctx.fillStyle = this.bgColor
      this.ctx.fillRect(0, 0, this.canvas.width, this.canvas.height)
      return
    }

    const cellSize = Math.max(1, Math.floor(maxWidth / width))
    const canvasW = width * cellSize
    const canvasH = rows.length * cellSize

    this.canvas.width = canvasW
    this.canvas.height = canvasH
    this.canvas.style.width = '100%'

    const ctx = this.ctx
    ctx.fillStyle = this.bgColor
    ctx.fillRect(0, 0, canvasW, canvasH)

    const imageData = ctx.createImageData(canvasW, canvasH)
    const data = imageData.data

    // Fill background into imageData
    const bgR = this.isDark ? 0x1d : 0xf5
    const bgG = this.isDark ? 0x23 : 0xf5
    const bgB = this.isDark ? 0x2a : 0xf5
    for (let i = 0; i < data.length; i += 4) {
      data[i] = bgR
      data[i + 1] = bgG
      data[i + 2] = bgB
      data[i + 3] = 255
    }

    for (let y = 0; y < rows.length; y++) {
      const row = rows[y]
      for (let x = 0; x < width; x++) {
        if (row[x] === 1) {
          // Gradient from cyan to purple based on row position
          const t = y / rows.length
          const r = Math.round(34 + t * 100)
          const g = Math.round(211 - t * 80)
          const b = Math.round(238 - t * 20)

          for (let dy = 0; dy < cellSize; dy++) {
            for (let dx = 0; dx < cellSize; dx++) {
              const px = x * cellSize + dx
              const py = y * cellSize + dy
              const idx = (py * canvasW + px) * 4
              data[idx] = r
              data[idx + 1] = g
              data[idx + 2] = b
              data[idx + 3] = 255
            }
          }
        }
      }
    }

    ctx.putImageData(imageData, 0, 0)
  },

  destroyed() {
    window.removeEventListener('resize', this.resizeHandler)
    if (this.themeObserver) this.themeObserver.disconnect()
  }
}

export default ElementaryCAHook
