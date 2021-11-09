const defaultTheme = require('tailwindcss/defaultTheme')
const colors = require('tailwindcss/colors')

module.exports = {
  purge: [],
  darkMode: 'media', // or 'media' or 'class'
  theme: {
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
      gray: colors.trueGray,
      red: colors.red,
      yellow: colors.amber,
      beige: {}
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
