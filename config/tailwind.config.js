const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*",
    "./app/components/**/*",
  ],
  theme: {
    colors: {
      inherit: "inherit",
      transparent: "transparent",
      current: "currentColor",
      white: "#ffffff",
      blue: {
        50: "#e9ebf3",
        100: "#d3d8e7",
        200: "#a6b0cf",
        300: "#7a89b7",
        400: "#4d619f",
        500: "#213a87",
        600: "#1a2e6c",
        700: "#142351",
        800: "#0d1736",
        900: "#070c1b",
      },
      yellow: {
        50: "#fffbe6",
        100: "#fff7cc",
        200: "#ffee99",
        300: "#ffe666",
        400: "#ffdd33",
        500: "#ffd500",
        600: "#ccaa00",
        700: "#998000",
        800: "#665500",
        900: "#332b00",
      },
      danger: "#e41438",
    },
    extend: {
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/typography"),
  ],
};
