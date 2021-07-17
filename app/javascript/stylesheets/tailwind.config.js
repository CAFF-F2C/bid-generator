const colors = require('tailwindcss/colors')

module.exports = {
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
    colors: {
      transparent: colors.transparent,
      white: colors.white,
      caffblue: {
        light: '#207A96',
        DEFAULT: '#295168',
      },
      gray: {
        dark: '#1E2E3A',
        700: '#335269',
        600: '#4D6D85',
        300: '#B2C3D0',
        10: '#F9FAFB',
      },
      red: {
        600: '#EA6042'
      }
    },
  },
  variants: {
    extend: {
      backgroundColor: ['checked'],
      borderColor: ['checked'],
    },
  },
  plugins: [require('@tailwindcss/forms')],
}
