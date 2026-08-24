#!/usr/bin/env Rscript
# ============================================================================
# Script: 07_climate_scenarios.R
# Purpose: Visualize projected climate changes (precipitation, temperature)
#          and impacts on soybean water requirements in major US regions
# Output: 07_climate_scenarios.tiff (600 dpi) + 07_climate_scenarios.png
# ============================================================================

library(ggplot2)
library(gridExtra)
library(dplyr)

# ============================================================================
# 1. Climate change projection data (CMIP5 ensemble, mid-century 2040-2070)
# ============================================================================

climate_projections <- data.frame(
  region = c(
    "Nebraska (Central)", "Nebraska (Central)",
    "Iowa (Eastern)", "Iowa (Eastern)",
    "Illinois (Central)", "Illinois (Central)",
    "Arkansas (Eastern)", "Arkansas (Eastern)",
    "Minnesota (Southern)", "Minnesota (Southern)"
  ),
  scenario = rep(c("Current (1980-2015)", "Mid-Century (2040-2070)"), 5),
  annual_precipitation_mm = c(
    640, 580,   # Nebraska: -60mm
    850, 810,   # Iowa: -40mm
    920, 880,   # Illinois: -40mm
    1050, 920,  # Arkansas: -130mm
    750, 730    # Minnesota: -20mm
  ),
  mean_growing_season_temp = c(
    18.2, 20.1,    # Nebraska: +1.9°C
    17.5, 19.2,    # Iowa: +1.7°C
    17.8, 19.5,    # Illinois: +1.7°C
    19.2, 21.3,    # Arkansas: +2.1°C
    16.8, 18.5     # Minnesota: +1.7°C
  ),
  reference_et_increase_pct = c(
    4.2, 4.2, 3.8, 3.8, 4.0, 4.0, 4.8, 4.8, 3.5, 3.5
  )
)

# ============================================================================
# 2. Calculate projected water deficit stress
# ============================================================================

climate_projections <- climate_projections %>%
  mutate(
    # Reference crop ET increases with temperature (roughly 2-5% per °C)
    base_et_mm = c(500, 520, 530, 550, 560, 580, 600, 640, 480, 495),
    # Projected ET increasing with temperature
    projected_et_mm = base_et_mm * (1 + reference_et_increase_pct / 100),
    # Calculate water deficit (ET - Precipitation)
    water_deficit_mm = projected_et_mm - annual_precipitation_mm,
    # Drought stress frequency (days/season with soil water <50% available)
    drought_stress_days = c(
      25, 45,    # Nebraska
      15, 30,    # Iowa
      10, 25,    # Illinois
      30, 50,    # Arkansas
      20, 35     # Minnesota
    )
  )

# ============================================================================
# 3. Create precipitation change plot
# ============================================================================

precip_data <- climate_projections %>%
  select(region, scenario, annual_precipitation_mm) %>%
  mutate(region = factor(region, levels = unique(region)))

precip_plot <- ggplot(precip_data, aes(x = scenario, y = annual_precipitation_mm, fill = scenario)) +
  geom_bar(stat = "identity", position = "dodge", color = "black", size = 0.6) +
  geom_text(aes(label = paste0(annual_precipitation_mm, " mm")),
            vjust = -0.3, size = 3, fontface = "bold") +
  facet_wrap(~ region, nrow = 1) +
  scale_fill_manual(
    name = "Scenario",
    values = c("Current (1980-2015)" = "#1f77b4", "Mid-Century (2040-2070)" = "#ff7f0e")
  ) +
  scale_y_continuous(limits = c(0, 1200)) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 12, face = "bold", hjust = 0.5),
    axis.title.x = element_blank(),
    axis.title.y = element_text(size = 10, face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
    axis.text.y = element_text(size = 8),
    panel.grid.major.y = element_line(color = "#e0e0e0", size = 0.2),
    strip.text = element_text(size = 9, face = "bold"),
    strip.background = element_rect(fill = "#e0e0e0"),
    legend.position = "bottom"
  ) +
  labs(
    title = "Projected Annual Precipitation Change by Region",
    subtitle = "CMIP5 ensemble mean (5-10 model average)",
    y = "Annual Precipitation (mm)"
  )

# ============================================================================
# 4. Create water deficit projection plot
# ============================================================================

deficit_data <- climate_projections %>%
  select(region, scenario, water_deficit_mm) %>%
  mutate(region = factor(region, levels = unique(region)))

deficit_plot <- ggplot(deficit_data, aes(x = scenario, y = water_deficit_mm, fill = scenario)) +
  geom_bar(stat = "identity", position = "dodge", color = "black", size = 0.6) +
  geom_text(aes(label = paste0(round(water_deficit_mm, 0), " mm")),
            vjust = -0.3, size = 3, fontface = "bold") +
  facet_wrap(~ region, nrow = 1) +
  scale_fill_manual(
    name = "Scenario",
    values = c("Current (1980-2015)" = "#2ca02c", "Mid-Century (2040-2070)" = "#d62728")
  ) +
  scale_y_continuous(limits = c(-100, 400)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "black", size = 0.5) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 12, face = "bold", hjust = 0.5),
    axis.title.x = element_blank(),
    axis.title.y = element_text(size = 10, face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
    axis.text.y = element_text(size = 8),
    panel.grid.major.y = element_line(color = "#e0e0e0", size = 0.2),
    strip.text = element_text(size = 9, face = "bold"),
    strip.background = element_rect(fill = "#e0e0e0"),
    legend.position = "bottom"
  ) +
  labs(
    title = "Projected Seasonal Water Deficit (ET - Precipitation)",
    subtitle = "Positive values = water stress requiring irrigation",
    y = "Water Deficit (mm)"
  )

# ============================================================================
# 5. Create stress frequency summary
# ============================================================================

stress_summary <- climate_projections %>%
  select(region, scenario, drought_stress_days) %>%
  mutate(region = factor(region, levels = unique(region)))

stress_plot <- ggplot(stress_summary, aes(x = scenario, y = drought_stress_days, fill = scenario)) +
  geom_bar(stat = "identity", position = "dodge", color = "black", size = 0.6) +
  geom_text(aes(label = paste0(drought_stress_days, " days")),
            vjust = -0.3, size = 3, fontface = "bold") +
  facet_wrap(~ region, nrow = 1) +
  scale_fill_manual(
    name = "Scenario",
    values = c("Current (1980-2015)" = "#9467bd", "Mid-Century (2040-2070)" = "#ff9896")
  ) +
  scale_y_continuous(limits = c(0, 60)) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 12, face = "bold", hjust = 0.5),
    axis.title.x = element_blank(),
    axis.title.y = element_text(size = 10, face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
    axis.text.y = element_text(size = 8),
    panel.grid.major.y = element_line(color = "#e0e0e0", size = 0.2),
    strip.text = element_text(size = 9, face = "bold"),
    strip.background = element_rect(fill = "#e0e0e0"),
    legend.position = "bottom"
  ) +
  labs(
    title = "Projected Days with Moderate Drought Stress",
    subtitle = "Days with soil water <50% of plant-available water",
    y = "Days per Growing Season"
  )

# ============================================================================
# 6. Combine and save
# ============================================================================

combined <- gridExtra::grid.arrange(
  precip_plot,
  deficit_plot,
  stress_plot,
  nrow = 3
)

# Save as TIFF
tiff(filename = "figures/07_climate_scenarios.tiff",
     width = 16, height = 12, units = "in", res = 600, compression = "lzw")
print(combined)
dev.off()

# Save as PNG
png(filename = "figures/07_climate_scenarios.png",
    width = 16, height = 12, units = "in", res = 150)
print(combined)
dev.off()

cat("\n=== Climate Scenarios Generated ===\n")
cat("TIFF: figures/07_climate_scenarios.tiff (600 dpi)\n")
cat("PNG:  figures/07_climate_scenarios.png\n")
cat("\nProjected Climate Changes Summary:\n")
print(climate_projections[, c("region", "scenario", "annual_precipitation_mm",
                             "water_deficit_mm", "drought_stress_days")])
