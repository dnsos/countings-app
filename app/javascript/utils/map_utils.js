import "maplibre-gl";

/**
 * Returns a geolocation in the format [longitude, latitude].
 */
export const DEFAULT_CENTER = [13.404954, 52.520008];

/**
 * Default map zoom (12).
 */
export const DEFAULT_ZOOM = 12;

/**
 * Returns MapTiler style URL.
 * @param {string} key - Maptiler API key (required).
 */
export const getMaptilerStyle = (key) => {
  return `https://api.maptiler.com/maps/cef2fea6-7018-4908-ad16-3a03fab46447/style.json?key=${key}`;
};

/**
 * Returns a MapLibreGL map instance.
 * @param {string} mapId - ID of wrapping DOM element (required).
 * @param {string} style - MapTiler style URL (required).
 * @param {Object} options - Additional options.
 * @param {integer} options.zoom - Initial zoom level of map.
 * @param {[integer, integer]} options.center - Initial map center.
 */
export const createMap = (
  mapId,
  style,
  { center = DEFAULT_CENTER, zoom = DEFAULT_ZOOM } = {}
) => {
  return new maplibregl.Map({
    container: mapId,
    style: style,
    center: center,
    zoom: zoom,
    attributionControl: false,
  }).addControl(new maplibregl.AttributionControl(), "bottom-left");
};
