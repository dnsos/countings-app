/**
 * Returns a geolocation in the format [longitude, latitude]
 */
export const DEFAULT_CENTER = [13.404954, 52.520008];

/**
 * Returns Maptiler style URL
 * @param {string} key - Maptiler API key (required)
 */
export const getMaptilerStyle = (key) => {
  return `https://api.maptiler.com/maps/bcd1a1a3-d07c-4faf-80f9-c8a4a28ab845/style.json?key=${key}`;
};
