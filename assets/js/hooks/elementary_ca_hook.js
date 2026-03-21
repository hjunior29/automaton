const ElementaryCAHook = {
  mounted() {
    this.canvas = this.el
    this.ctx = this.canvas.getContext('2d')

    this.handleEvent("render_ca", ({ rows, width }) => {
      this.renderCA(rows, width)
    })
  },

  renderCA(rows, width) {
    const container = this.canvas.parentElement
    const maxWidth = container.clientWidth
    const cellSize = Math.max(1, Math.min(4, Math.floor(maxWidth / width)))

    this.canvas.width = width * cellSize
    this.canvas.height = rows.length * cellSize

    const ctx = this.ctx
    ctx.fillStyle = '#0a0e1a'
    ctx.fillRect(0, 0, this.canvas.width, this.canvas.height)

    const imageData = ctx.createImageData(this.canvas.width, this.canvas.height)
    const data = imageData.data

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
              const idx = (py * this.canvas.width + px) * 4
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

  destroyed() {}
}

export default ElementaryCAHook
