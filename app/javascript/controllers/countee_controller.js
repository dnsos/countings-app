import { Controller } from "@hotwired/stimulus";
import { getMaptilerStyle, createMap } from "utils/map_utils";
import "maplibre-gl";
import bbox from "@turf/bbox";

let map = null;
let marker = null;

export default class extends Controller {
  static values = {
    "maptiler-key": String,
  };

  static targets = ["coordinates", "latitude", "longitude", "form", "area"];

  disconnect() {
    map = null;
    marker = null;
  }

  initialize() {
    if (!map) {
      map = createMap("map", getMaptilerStyle(this.maptilerKeyValue));

      map.addControl(
        new maplibregl.GeolocateControl({
          positionOptions: {
            enableHighAccuracy: true,
          },
          trackUserLocation: true,
          fitBoundsOptions: {
            maxZoom: 19,
          },
        }),
        "bottom-right"
      );

      map.on("click", (event) => {
        const { lng, lat } = event.lngLat;

        if (!marker) {
          // If there is no marker yet (i.e. after the first click), we assign a real marker to the variable "marker" and add it to the map:
          marker = new maplibregl.Marker({
            draggable: false,
            color: "#ffffff",
          })
            .setLngLat([lng, lat])
            .addTo(map);
        } else {
          // After the first click the "marker" variable is not empty anymore, and is therefore only update by latitude and longitude:
          marker.setLngLat([lng, lat]);
        }

        this.longitudeTarget.value = lng;
        this.latitudeTarget.value = lat;

        marker.setLngLat([lng, lat]);
      });
    }
  }

  /**
   * Adds a marker to the map and sets the input fields if explicit coordinates are provided
   * @param {*} element HTMLElement
   */
  coordinatesTargetConnected(element) {
    const latitude = element.dataset.latitude;
    const longitude = element.dataset.longitude;

    if (latitude && longitude) {
      this.longitudeTarget.value = longitude;
      this.latitudeTarget.value = latitude;

      marker = new maplibregl.Marker({
        draggable: false,
        color: "#ffffff",
      })
        .setLngLat([parseFloat(longitude), parseFloat(latitude)])
        .addTo(map);
    }
  }

  /**
   * Removes the marker from the map whenever a new form is rendered (i.e. a "new" template has been rendered).
   */
  formTargetDisconnected(_formElement) {
    if (!!marker) {
      marker.remove();
      marker = null;
      this.longitudeTarget.value = null;
      this.latitudeTarget.value = null;
    }
  }

  areaTargetConnected() {
    this.createAreaLayer(this.areaTarget.dataset.areaPath);
  }

  /**
   * Fetches a GeoJSON object based on the provided areaPath,
   * displays it as a polygon on the map, and eases the map to its bounds.
   * @param {*} areaPath string
   * @returns void
   */
  async createAreaLayer(areaPath) {
    if (!map) return;

    const AREA_SOURCE_ID = `${areaPath}-source`;

    const areaResponse = await fetch(areaPath);
    const areaGeojson = await areaResponse.json();

    map.on("load", () => {
      const sourceAlreadyExists = !!map.getSource(AREA_SOURCE_ID);
      if (sourceAlreadyExists) return;

      map.addSource(AREA_SOURCE_ID, {
        type: "geojson",
        data: areaGeojson,
      });

      const AREA_LAYER_ID = `${areaPath}-layer`;

      map.addLayer({
        id: AREA_LAYER_ID,
        type: "fill",
        source: AREA_SOURCE_ID,
        layout: {},
        paint: {
          "fill-color": "#ffdd33",
          "fill-opacity": 0.5,
        },
      });

      const areaBoundingBox = bbox(areaGeojson);

      map.fitBounds(areaBoundingBox, { padding: 10 });
    });
  }
}
