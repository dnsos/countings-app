import { Controller } from "@hotwired/stimulus";
import { getMaptilerStyle, createMap } from "utils/map_utils";
import "maplibre-gl";

let map = null;
let marker = null;

export default class extends Controller {
  static values = {
    "maptiler-key": String,
  };

  static targets = ["latitude", "longitude", "form"];

  disconnect() {
    console.log("Map disconnected");
  }

  initialize() {
    console.log("Map", map);
    if (!map) {
      map = createMap("map", getMaptilerStyle(this.maptilerKeyValue));

      map.addControl(new maplibregl.NavigationControl(), "bottom-right");

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
}
