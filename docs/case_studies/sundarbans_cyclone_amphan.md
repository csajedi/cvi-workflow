# Sundarbans Cyclone Amphan Analysis

**Objective:** Assess Cyclone Amphan (May 2020) impact on the Sundarbans mangrove delta using ESA WorldCover change detection (2020 vs 2021).

## Key Finding

| Location | Transects | Coverage | Mangrove Change | Interpretation |
|----------|-----------|----------|-----------------|----------------|
| Inland (Tiger Reserve) | 285 | 15km | -0.4% (stable) | Protected, sheltered |
| **Seaward (Dublar Char)** | 995 | 50km | **-8.3%** | **Cyclone damage signature** |

**Conclusion:** Study design critically affects results. The exposed seaward coast shows significant land cover change consistent with cyclone damage, while the inland protected area remained stable.

---

## Study Design

### Attempt 1: Inland Coast (Negative Result)

**Location:** Western Sundarbans (88.63°E), adjacent to Sundarbans Tiger Reserve
**Why this location:** Default algorithm starts transect generation from westernmost coastline point
**Coverage:** 15km of 6,738km total coastline (0.22%)

**Results:**
- 285 transects analyzed
- Mangroves 2020: 98.6% → 2021: 98.2%
- Change: 3 transects (1.1%)
- **Interpretation:** Inland/protected area not representative of cyclone damage zone

### Attempt 2: Seaward Coast (Positive Result)

**Location:** Dublar Char Island (21.78°N, 89.57°E) - outer island facing Bay of Bengal
**Why this location:** Explicitly targeted exposed seaward coastline
**Coverage:** 50km of 167km island coastline (30%)

**Results:**
- 995 transects analyzed
- Mangroves 2020: 85.5% → 2021: 78.4%
- **Change: 121 transects (12.2%)**
- **Mangrove loss: 71 transects (-8.3%)**

**Change Breakdown:**
| Change Type | Count | Interpretation |
|-------------|-------|----------------|
| Mangroves → Bare vegetation | 28 | Direct damage/dieback |
| Mangroves → Grassland | 24 | Partial recovery to herbaceous |
| Cropland → Grassland | 24 | Agricultural abandonment |
| Mangroves → Tree cover | 17 | Classification refinement |

---

## Methods

### Data Sources
- **Land Cover:** ESA WorldCover 10m
  - 2020 v100 (released October 2020)
  - 2021 v200 (released October 2022)
- **Coastline:** OpenStreetMap via Overpass API
- **Elevation/Slope:** Copernicus DEM 30m

### Workflow
1. Extract coastline geometry from OSM
2. Generate perpendicular transects (50m spacing, 400m length)
3. Sample ESA WorldCover for each transect
4. Compare 2020 vs 2021 land cover classifications

### Parameters
```
Transect spacing: 50m
Transect length: 400m
Max coastline: 50km (increased from default 15km)
```

---

## Limitations

### Data Limitations
1. **Annual composite:** ESA WorldCover averages entire year - cannot capture May 2020 event + subsequent recovery
2. **Version differences:** v100 (2020) and v200 (2021) use different classification algorithms
3. **10m resolution:** May miss fine-scale damage patterns

### Methodology Limitations
1. **Starting point bias:** Default algorithm begins at westernmost point
2. **Linear sampling:** Transects sample coastline, not full inland extent
3. **Single-year comparison:** Cannot isolate cyclone damage from other change drivers

---

## Conclusions

### Study Design Matters
The initial "negative result" from inland Sundarbans led us to question the methodology. Redirecting to the exposed seaward coast revealed a **12.2% land cover change rate** and **8.3% mangrove loss** - consistent with cyclone damage on exposed coastlines.

### CVI Workflow Applicability
- ✅ **Can detect** year-over-year land cover change
- ✅ **Requires** explicit study area selection (not default algorithm)
- ⚠️ **Not suited** for event-scale (days/weeks) damage assessment
- ⚠️ **Annual data** masks rapid recovery typical of mangrove ecosystems

### Recommendations for Future Work
1. **For cyclone damage assessment:** Use Sentinel-2 NDVI time series (pre/post event dates)
2. **For study area selection:** Specify explicit coordinates rather than relying on place-name geocoding
3. **For regional studies:** Increase `max_length_m` parameter or iterate across full coastline

---

## Files

```
output_data/sundarbans/
├── attempt1_inland/
│   ├── transects_landcover_2020.geojson
│   ├── transects_landcover_2021.geojson
│   └── change_map.html
└── attempt2_seaward/
    ├── transects_landcover_2020.geojson
    ├── transects_landcover_2021.geojson
    └── change_map.html
```

---

## References

- Cyclone Amphan (May 2020): Category 5 super cyclone, 1,200 km² mangrove damage reported
- ESA WorldCover: https://esa-worldcover.org/
- Sundarbans UNESCO World Heritage Site: https://whc.unesco.org/en/list/798
