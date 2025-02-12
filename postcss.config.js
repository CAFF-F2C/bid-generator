let environment = {
  plugins: [
    require('postcss-import-ext-glob'),
    require('postcss-import'),
    require('tailwindcss/nesting'),
    require('tailwindcss'),
    require('autoprefixer'),
  ]
}

if (process.env.RAILS_ENV === 'production') {
  environment.plugins.push(
    require('@fullhuman/postcss-purgecss')({
      content: [
        './app/**/*.erb',
        './app/javascript/**/*.css',
        './app/javascript/**/*.js',
        './app/components/**/*.erb',
        './app/components/**/*.css',
        './app/components/**/*.js',
        './app/components/**/*.rb',
      ],
      defaultExtractor: content => content.match(/[A-Za-z0-9-_:/]+/g) || []
    })
  )
}

module.exports = environment
