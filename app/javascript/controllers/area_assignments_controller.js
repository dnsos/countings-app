import { Controller } from "@hotwired/stimulus";
import "maplibre-gl";

let areas = [];
let assignedAreaIds = [];
let areaAssignments = [];

export default class extends Controller {
  static values = {
    areasGeojsonPath: String,
    assignmentsPath: String,
    center: { type: String, default: "13.404954,52.520008" },
    zoom: { type: Number, default: 11 },
    minZoom: { type: Number, default: 0 },
    maxZoom: { type: Number, default: 22 },
    styleUrl: String,
  };

  static targets = [
    "areaAssignmentActivity",
    "areaAssignmentForm",
    "mapContainer",
  ];

  async connect() {
    await this.loadAreas();
    await this.loadAreaAssignments();

    this.map = new maplibregl.Map({
      container: this.mapContainerTarget,
      style: this.styleUrlValue,
      center: [this.longitude, this.latitude],
      zoom: this.zoomValue,
      minZoom: this.minZoomValue,
      maxZoom: this.maxZoomValue,
    });

    this.map.on("load", () => {
      this.map.addSource(this.areasSourceId, {
        type: "geojson",
        data: areas,
        promoteId: "id",
      });

      this.map.addLayer({
        id: this.areasLayerId,
        type: "fill",
        source: this.areasSourceId,
        paint: {
          "fill-color": [
            "case",
            ["boolean", ["feature-state", "assigned"], false],
            "#ffff00",
            "#3112ff",
          ],
          "fill-opacity": 0.5,
          "fill-outline-color": "#ffff00",
        },
      });

      this.assignAreaFeatureStates(areas, areaAssignments);
    });

    this.map.on("click", this.areasLayerId, (evt) => {
      const clickedAreaId = evt.features[0].properties.id;

      const formPath = assignedAreaIds.includes(clickedAreaId)
        ? `${this.assignmentsPathValue}/${
            areaAssignments.find((a) => a.counting_area_id === clickedAreaId).id
          }/edit`
        : `${this.assignmentsPathValue}/new?counting_area_id=${clickedAreaId}`;

      this.areaAssignmentFormTarget.src = formPath;
    });
  }

  /**
   * Upon new connection of an areaAssignmentActivityTarget
   * we re-fetch the area assignments, so we have the latest data.
   * We then update all areas and assign them their new feature state.
   */
  async areaAssignmentActivityTargetConnected() {
    await this.loadAreaAssignments();
    this.assignAreaFeatureStates(areas, areaAssignments);
  }

  assignAreaFeatureStates(areas, areaAssignments) {
    areas.features.forEach((area) => {
      this.map.setFeatureState(
        {
          source: this.areasSourceId,
          id: area.properties.id,
        },
        {
          assigned: areaAssignments
            .map((assignment) => assignment.counting_area_id)
            .includes(area.properties.id),
        }
      );
    });
  }

  get areasLayerId() {
    return "areas";
  }

  get areasSourceId() {
    return this.areasGeojsonPathValue;
  }

  /**
   * Returns the latitude value from the center string.
   * @returns number
   */
  get latitude() {
    const [, latitude] = this.centerValue.split(",");
    return parseFloat(latitude);
  }

  /**
   * Returns the longitude value from the center string.
   * @returns number
   */
  get longitude() {
    const [longitude] = this.centerValue.split(",");
    return parseFloat(longitude);
  }

  /**
   * Fetches JSON data from any valid JSON URL.
   */
  async fetchJson(url) {
    try {
      const response = await fetch(url);
      const jsonData = await response.json();
      return jsonData;
    } catch (error) {
      throw new Error(`Failed tpo fetch resource from URL ${url}`);
    }
  }

  async loadAreas() {
    areas = await this.fetchJson(this.areasGeojsonPathValue);
  }

  async loadAreaAssignments() {
    areaAssignments = await this.fetchJson(this.assignmentsPathValue);

    assignedAreaIds = areaAssignments.map(
      (assignment) => assignment.counting_area_id
    );
  }
}
