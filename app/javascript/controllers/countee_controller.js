import { Controller } from "@hotwired/stimulus";
import { getMaptilerStyle, createMap } from "utils/map_utils";
import "maplibre-gl";
import bbox from "@turf/bbox";

let map = null;
let mapHasInitiallyLoaded = null;

export default class extends Controller {
  static values = {
    "maptiler-key": String,
  };

  static targets = ["form", "area", "countingAreaIdInput"];

  disconnect() {
    map = null;
    marker = null;
    mapHasInitiallyLoaded = null;
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
        mapHasInitiallyLoaded = true;
      });
    }
  }

  /*
    After the form has been submitted and a Turbo Stream has
    replaced the old form with a fresh one, we need to reload
    the frame of the active counting area. This is because we
    need to trigger a fresh areaTargetConnected to assign the
    last/current counting area ID to the input field again.
  */
  formTargetConnected() {
    const activeCountingAreaFrame = document.querySelector(
      "#active_counting_area"
    );

    activeCountingAreaFrame?.reload();
  }

  areaTargetConnected(element) {
    window.history.replaceState(
      null,
      null,
      `?counting_area_id=${element.dataset.areaId}`
    );

    /*
      Here we set the value of the counting_area_id input field
      to the ID of the counting area that was just added to the DOM.
    */
    this.countingAreaIdInputTarget.value = element.dataset.areaId;

    /*
      This check prevents a duplicate layer addition because upon initial
      loading the layer is added in map.on("load"). After that
      mapHasInitiallyLoaded is set to true and the following check will
      never stop the layer creation anymore.
    */
    if (!mapHasInitiallyLoaded) return;

    this.createAreaLayer(this.areaPath);
  }

  areaTargetDisconnected(element) {
    /*
      When an area target is removed from the DOM, we want to take its
      associated area path and remove layer and source from the map.
    */
    const areaPathOfDisconnectedTarget = element.dataset.areaPath;

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

  async createAreaLayer() {
    if (!map) return;

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
      linear: true,
      // Don't animate when user prefers-reduced-motion:
      essential: false,
    });
  }

  get areaPath() {
    return `${this.areaTarget.dataset.areaPath}`;
  }
}
