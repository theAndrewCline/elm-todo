const path = require('path')
const HtmlLoader = require('html-webpack-plugin')

module.exports = {
  entry: './src/main.js',
  output: {
    path: path.resolve(__dirname, 'build'),
    filename: 'index.js'
  },
  module: {
    rules: [
      {
        test: /\.elm$/,
        use: {
          loader: 'elm-webpack-loader',
          options: {}
        }
      }
    ]
  },
  plugins: [new HtmlLoader({ template: './public/index.html' })],
  devServer: {
    watchContentBase: true,
    contentBase: path.join(__dirname, 'build'),
    compress: true,
    open: true,
    port: 3000,
    host: '0.0.0.0',
    stats: {
      colors: true,
      hash: false,
      version: false,
      timings: false,
      assets: false,
      chunks: false,
      modules: false,
      reasons: false,
      children: false,
      source: false,
      errors: false,
      errorDetails: false,
      warnings: false,
      publicPath: false
    }
  }
}
