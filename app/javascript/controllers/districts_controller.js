import { Controller } from "@hotwired/stimulus";
import { DEFAULT_CENTER, getMaptilerStyle } from "utils/map_utils";
import "maplibre-gl";

export default class extends Controller {
  static values = {
    "results-url": String,
    "maptiler-key": String,
  };

  initialize() {
    if (!this.hasMaptilerKeyValue) return;

    this.map = new maplibregl.Map({
      container: "map-root",
      style: getMaptilerStyle(this.maptilerKeyValue),
      center: DEFAULT_CENTER,
      zoom: 9,
      interactive: false,
    });

    this.map.on("load", () => {
      this.fitToBerlin();

      this.getGeojson().then((res) => {
        this.map.addSource("results", {
          type: "geojson",
          data: res,
        });

        this.map.addLayer({
          id: "districts_with_stats",
          type: "fill",
          source: "results",
          layout: {},
          paint: {
            "fill-color": "#ffd500",
            "fill-opacity": [
              "case",
              [">=", ["get", "people_count"], 100],
              0.8,
              [">=", ["get", "people_count"], 80],
              0.6,
              [">=", ["get", "people_count"], 60],
              0.4,
              0.2,
            ],
          },
        });
      });
    });
  }

  getGeojson = async () => {
    const response = await fetch(this.resultsUrlValue);
    const data = await response.json();
    return data;
  };

  fitToBerlin() {
    const MIN_LATITUDE = 52.341155;
    const MAX_LATITUDE = 52.672539;
    const MIN_LONGITUDE = 13.07177;
    const MAX_LONGITUDE = 13.785576;

    this.map.fitBounds(
      [
        [MIN_LONGITUDE, MAX_LATITUDE], // southwestern corner of the bounds
        [MAX_LONGITUDE, MIN_LATITUDE], // northeastern corner of the bounds
      ],
      {
        padding: { top: 20, bottom: 20, left: 20, right: 20 },
      }
    );
  }
}
