const defaultTheme = require('tailwindcss/defaultTheme')
const colors = require('tailwindcss/colors')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/components/**/*{erb,haml,html,slim,js}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        transparent: 'transparent',
        current: 'currentColor',
        cyan: colors.cyan,
        white: colors.white,
        green: colors.green,
        blue: colors.blue,
        gray: colors.neutral,
        red: colors.red,
        yellow: colors.amber,
        indigo: colors.indigo,
        beige: {}
      },
    },
  },
  variants: {
    extend: {
      backgroundColor: ['checked', 'active'],
      borderColor: ['checked', 'active'],
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
