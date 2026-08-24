#!/usr/bin/env Rscript
# ============================================================================
# Script: 01_study_locations_map.R
# Purpose: Generate map of proposed study locations for soybean deficit
#          irrigation research across major US soybean-growing regions
# Output: 01_study_locations_map.tiff (600 dpi) + 01_study_locations_map.png
# ============================================================================

# Install required packages if needed
required_packages <- c("ggplot2", "maps", "mapdata", "dplyr", "gridExtra")
new_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) install.packages(new_packages, dependencies = TRUE)

# Load libraries
library(ggplot2)
library(maps)
library(mapdata)
library(dplyr)

# ============================================================================
# 1. Define study locations across major soybean-growing regions
# ============================================================================

# Study sites in major soybean states with high irrigation potential
study_sites <- data.frame(
  site_name = c(
    "Nebraska (Central)",
    "Iowa (Eastern)",
    "Illinois (Central)",
    "Minnesota (Southern)",
    "Arkansas (Eastern)"
  ),
  latitude = c(40.8, 41.5, 40.0, 44.0, 34.8),
  longitude = c(-99.0, -93.5, -88.5, -94.0, -91.0),
  irrigation_potential = c("High", "Medium", "Low-Medium", "Low", "High"),
  annual_rainfall_mm = c(640, 850, 920, 750, 1050)
)

# Get US map data
us_map <- map_data("state")

# ============================================================================
# 2. Create the map
# ============================================================================

map_plot <- ggplot() +
  # Plot US map
  geom_polygon(data = us_map, aes(x = long, y = lat, group = group),
               fill = "#e8e8e8", color = "#cccccc", size = 0.3) +
  # Add state borders
  geom_path(data = us_map, aes(x = long, y = lat, group = group),
            color = "#999999", size = 0.2) +
  # Add study sites
  geom_point(data = study_sites, aes(x = longitude, y = latitude,
                                      color = irrigation_potential,
                                      size = 5),
             alpha = 0.8, show.legend = TRUE) +
  # Add site labels
  geom_text(data = study_sites, aes(x = longitude, y = latitude,
                                    label = site_name),
            vjust = -1.2, hjust = 0.5, size = 3.5, fontface = "bold") +
  # Add scale bar and styling
  coord_fixed(1.3, xlim = c(-105, -75), ylim = c(30, 48)) +
  scale_color_manual(name = "Irrigation\nPotential",
                     values = c("High" = "#d73027", "Medium" = "#fee090",
                               "Low" = "#1a9850", "Low-Medium" = "#91bfdb")) +
  scale_size_continuous(guide = "none") +
  theme_minimal() +
  theme(
    axis.title = element_blank(),
    axis.text = element_text(size = 10),
    axis.line = element_line(color = "black", size = 0.3),
    panel.grid = element_line(color = "#e0e0e0", size = 0.2),
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 11, hjust = 0.5, color = "#555555"),
    legend.position = "right",
    legend.text = element_text(size = 10),
    legend.title = element_text(size = 10, face = "bold")
  ) +
  labs(
    title = "Proposed Study Locations: Soybean Deficit Irrigation",
    subtitle = "Distribution across major US soybean-growing regions"
  )

# ============================================================================
# 3. Add summary statistics table
# ============================================================================

# Create summary table
summary_table <- ggplot(study_sites, aes(x = 1, y = 1)) +
  annotate("text", x = 0.5, y = 0.95, label = "Study Site Summary Statistics",
           fontface = "bold", size = 4, hjust = 0, vjust = 1) +
  annotate("text", x = 0.5, y = 0.85,
           label = paste("Number of sites: ", nrow(study_sites)),
           size = 3.5, hjust = 0, vjust = 1) +
  annotate("text", x = 0.5, y = 0.75,
           label = paste("Latitude range: ",
                        min(study_sites$latitude), "° to ",
                        max(study_sites$latitude), "°N"),
           size = 3.5, hjust = 0, vjust = 1) +
  annotate("text", x = 0.5, y = 0.65,
           label = paste("Annual rainfall range: ",
                        min(study_sites$annual_rainfall_mm), " to ",
                        max(study_sites$annual_rainfall_mm), " mm"),
           size = 3.5, hjust = 0, vjust = 1) +
  annotate("text", x = 0.5, y = 0.55,
           label = "High irrigation potential: 2 sites",
           size = 3.5, hjust = 0, vjust = 1) +
  xlim(0, 1) + ylim(0, 1) +
  theme_void()

# ============================================================================
# 4. Combine and save outputs
# ============================================================================

# Combine plots
combined_plot <- gridExtra::grid.arrange(map_plot, summary_table,
                                         nrow = 2, heights = c(4, 1.2))

# Save as TIFF at 600 dpi
tiff(filename = "figures/01_study_locations_map.tiff",
     width = 10, height = 8, units = "in", res = 600, compression = "lzw")
print(map_plot)
dev.off()

# Save as PNG
png(filename = "figures/01_study_locations_map.png",
    width = 10, height = 8, units = "in", res = 150)
print(map_plot)
dev.off()

# Print summary
cat("\n=== Study Locations Map Generated ===\n")
cat("TIFF: figures/01_study_locations_map.tiff (600 dpi)\n")
cat("PNG:  figures/01_study_locations_map.png\n")
cat("\nStudy Sites:\n")
print(study_sites)
cat("\n")
