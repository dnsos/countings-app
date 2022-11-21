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

      map.on("load", () => {
        this.createAreaLayer(this.areaPath);
      });

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

  /*
    Removes the marker from the map whenever a new form is rendered
    (i.e. a "new" template has been rendered).
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
    /*
      The first time the area target is connected, we don't want to draw it,
      hence the if check. This is because we do the initial drawing above
      in the map.on("load") function which ensures that the layer is added
      only after the map is ready. Subsequent changes of the area target
      will dispatch the createAreaLayer function here, because the map will
      be loaded by then.
    */
    if (!map.loaded()) return;

    this.createAreaLayer(this.areaPath);
  }

  areaTargetDisconnected(element) {
    /*
      When an area target is removed from the DOM, we want to take its
      associated area path and remove layer and source from the map.
    */
    const areaPathOfDisconnectedTarget = element.dataset.areaPath;

    // We can only remove something from the map if the map has loaded.
    if (!map.loaded()) return;

    /*
      Can't remove a source that has layer attached to it. That's why
      first the layer is removed.
    */
    if (!!map.getLayer(areaPathOfDisconnectedTarget)) {
      map.removeLayer(areaPathOfDisconnectedTarget);
    }
    if (!!map.getSource(areaPathOfDisconnectedTarget)) {
      map.removeSource(areaPathOfDisconnectedTarget);
    }
  }

  /**
   * Fetches a GeoJSON object based on the provided areaPath,
   * displays it as a polygon on the map, and eases the map to its bounds.
   * @param {*} areaPath string
   * @returns void
   */
  async createAreaLayer() {
    if (!map) return;

    /*
      If we've got a previous source/layer for an area already, we remove
      these first:
    */

    const AREA_SOURCE_ID = this.areaPath;

    const areaResponse = await fetch(this.areaPath);
    const areaGeojson = await areaResponse.json();

    const sourceAlreadyExists = !!map.getSource(AREA_SOURCE_ID);
    if (sourceAlreadyExists) return;

    map.addSource(AREA_SOURCE_ID, {
      type: "geojson",
      data: areaGeojson,
    });

    const AREA_LAYER_ID = this.areaPath;

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

    map.fitBounds(areaBoundingBox, {
      padding: 10,
      // Don't animate when user prefers-reduced-motion:
      essential: false,
    });
  }

  get areaPath() {
    return `${this.areaTarget.dataset.areaPath}`;
  }
}
