const PopulationChartHook = {
  mounted() {
    this.canvas = this.el
    this.ctx = this.canvas.getContext('2d')
    this.history = []
    this.maxPoints = 200

    this.updateColors()

    requestAnimationFrame(() => {
      this.resize()

      this.resizeHandler = () => this.resize()
      window.addEventListener('resize', this.resizeHandler)
    })

    // Re-read colors when theme changes
    this.themeObserver = new MutationObserver(() => {
      this.updateColors()
      this.draw()
    })
    this.themeObserver.observe(document.documentElement, {
      attributes: true,
      attributeFilter: ['data-theme']
    })

    this.handleEvent("update_chart", ({ generation, population }) => {
      this.history.push({ gen: generation, pop: population })
      if (this.history.length > this.maxPoints) {
        this.history = this.history.slice(-this.maxPoints)
      }
      this.draw()
    })

    this.handleEvent("clear_chart", () => {
      this.history = []
      this.draw()
    })
  },

  updateColors() {
    const style = getComputedStyle(document.documentElement)
    const theme = document.documentElement.getAttribute('data-theme')
    const isDark = theme === 'dark' ||
      (!theme && window.matchMedia('(prefers-color-scheme: dark)').matches)

    this.lineColor = '#6366f1'
    this.fillColor = 'rgba(99, 102, 241, 0.15)'
    this.textColor = isDark ? '#e5e5e5' : '#18181b'
    this.axisColor = isDark ? '#71717a' : '#a1a1aa'
    this.gridColor = isDark ? '#27272a' : '#e4e4e7'
    this.bgColor = isDark ? '#1d232a' : '#ffffff'
  },

  resize() {
    const container = this.canvas.parentElement
    const rect = container.getBoundingClientRect()
    const dpr = window.devicePixelRatio || 1

    this.canvas.width = rect.width * dpr
    this.canvas.height = rect.height * dpr
    this.canvas.style.width = rect.width + 'px'
    this.canvas.style.height = rect.height + 'px'
    this.ctx.setTransform(dpr, 0, 0, dpr, 0, 0)

    this.drawWidth = rect.width
    this.drawHeight = rect.height

    this.draw()
  },

  draw() {
    const ctx = this.ctx
    const w = this.drawWidth
    const h = this.drawHeight

    if (!w || !h) return

    // Margins: left for Y labels, bottom for X labels, top for overlay text
    const ml = 40, mr = 10, mt = 20, mb = 20
    const pw = w - ml - mr
    const ph = h - mt - mb

    // Clear
    ctx.fillStyle = this.bgColor
    ctx.fillRect(0, 0, w, h)

    // Use history or default to gen 0 / pop 0
    const data = this.history.length > 0
      ? this.history
      : [{ gen: 0, pop: 0 }]

    // Compute ranges
    const minGen = data[0].gen
    const maxGen = data[data.length - 1].gen
    const genRange = Math.max(maxGen - minGen, 1)

    let minPop = Infinity, maxPop = 0
    for (const p of data) {
      if (p.pop < minPop) minPop = p.pop
      if (p.pop > maxPop) maxPop = p.pop
    }

    // If all values are the same, create a range around that value
    if (minPop === maxPop) {
      minPop = Math.max(0, minPop - 10)
      maxPop = maxPop + 10
    }

    // Add 10% padding on both sides
    const popPadding = Math.max((maxPop - minPop) * 0.1, 1)
    const popFloor = Math.max(0, Math.floor(minPop - popPadding))
    const popCeil = Math.ceil(maxPop + popPadding)
    const popRange = popCeil - popFloor

    // Draw horizontal grid lines
    ctx.strokeStyle = this.gridColor
    ctx.lineWidth = 0.5
    ctx.font = '9px ui-monospace, monospace'
    ctx.fillStyle = this.axisColor
    ctx.textAlign = 'right'
    ctx.textBaseline = 'middle'

    const yTicks = 4
    for (let i = 0; i <= yTicks; i++) {
      const val = Math.round(popFloor + (popRange / yTicks) * i)
      const y = mt + ph - (i / yTicks) * ph

      ctx.beginPath()
      ctx.moveTo(ml, y)
      ctx.lineTo(ml + pw, y)
      ctx.stroke()

      ctx.fillText(this.formatNumber(val), ml - 4, y)
    }

    // X axis labels (generation)
    ctx.textAlign = 'center'
    ctx.textBaseline = 'top'
    ctx.fillText(String(minGen), ml, mt + ph + 4)
    ctx.fillText(String(maxGen), ml + pw, mt + ph + 4)

    // Plot line
    ctx.beginPath()
    for (let i = 0; i < data.length; i++) {
      const p = data[i]
      const x = ml + ((p.gen - minGen) / genRange) * pw
      const y = mt + ph - ((p.pop - popFloor) / popRange) * ph

      if (i === 0) ctx.moveTo(x, y)
      else ctx.lineTo(x, y)
    }

    ctx.strokeStyle = this.lineColor
    ctx.lineWidth = 1.5
    ctx.lineJoin = 'round'
    ctx.stroke()

    // Fill under curve
    const lastPoint = data[data.length - 1]
    const lastX = ml + ((lastPoint.gen - minGen) / genRange) * pw
    const firstX = ml + ((data[0].gen - minGen) / genRange) * pw

    ctx.lineTo(lastX, mt + ph)
    ctx.lineTo(firstX, mt + ph)
    ctx.closePath()
    ctx.fillStyle = this.fillColor
    ctx.fill()

    // Overlay: current gen & pop
    const current = data[data.length - 1]
    ctx.fillStyle = this.textColor
    ctx.font = 'bold 10px ui-monospace, monospace'
    ctx.textAlign = 'right'
    ctx.textBaseline = 'top'
    ctx.fillText(
      `Gen ${current.gen}  Pop ${current.pop}`,
      ml + pw, 4
    )
  },

  formatNumber(n) {
    if (n >= 1000) return (n / 1000).toFixed(1) + 'k'
    return String(n)
  },

  destroyed() {
    window.removeEventListener('resize', this.resizeHandler)
    if (this.themeObserver) this.themeObserver.disconnect()
  }
}

export default PopulationChartHook
