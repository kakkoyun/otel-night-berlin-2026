const marpKrokiPlugin = require('./kroki-plugin')
module.exports = {
  html: true,
  options: { emoji: { shortcode: true, unicode: false } },
  engine: ({ marp }) => marp.use(marpKrokiPlugin),
}
