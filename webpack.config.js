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
      },
      {
        test: /\.css$/,
        use: [
          {
            loader: 'postcss-loader',
            options: {
              ident: 'postcss',
              plugins: [require('tailwindcss'), require('autoprefixer')]
            }
          }
        ]
      }
    ]
  },
  plugins: [new HtmlLoader({ template: './public/index.html' })],
  devServer: {
    contentBase: path.join(__dirname, 'build'),
    compress: true,
    port: 3000
  }
}
