const defaultTheme = require('tailwindcss/defaultTheme')
const colors = require('tailwindcss/colors')

module.exports = {
  purge: [],
  darkMode: 'media', // or 'media' or 'class'
  theme: {
    fontFamily: {
      sans: ['Inter', ...defaultTheme.fontFamily.sans],
      display: ['"Space Grotesk"', ...defaultTheme.fontFamily.sans],
    },
    colors: {
      transparent: 'transparent',
      white: colors.white,
      green: colors.green,
      blue: {
        50: '#E2F8FF',
        100: '#B2E2F1',
        200: '#88CCE2',
        300: '#61B4CE',
        400: '#50A5BF',
        500: '#3E93AE',
        600: '#2A87A4',
        700: '#207A96',
        800: '#295168',
        900: '#1D384C'
      },
      gray: {
        50: '#F9FAFB',
        100: '#F0F4F6',
        200: '#C7D5E0',
        300: '#B2C3D0',
        400: '#8EA4B6',
        500: '#69869B',
        600: '#4D6D85',
        700: '#335269',
        800: '#263B4A',
        900: '#1E2E3A'
      },
      red: {
        50: '#FFE7E1',
        100: '#FFC0B1',
        200: '#FF9F89',
        300: '#FF9279',
        400: '#FA8166',
        500: '#F37256',
        600: '#EA6042',
        700: '#B91C1C',
        800: '#991B1B',
        900: '#7F1D1D'
      },
      orange: {
        50: '#FFF7ED',
        100: '#FFEDD5',
        200: '#FED7AA',
        300: '#FFAF70',
        400: '#F68933',
        500: '#F97316',
        600: '#EA580C',
        700: '#C2410C',
        800: '#9A3412',
        900: '#7C2D12'
      },
      beige: {}
    },
  },
  variants: {
    extend: {
      backgroundColor: ['checked'],
      borderColor: ['checked'],
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
