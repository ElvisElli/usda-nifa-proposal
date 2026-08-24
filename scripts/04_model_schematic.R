#!/usr/bin/env Rscript
# ============================================================================
# Script: 04_model_schematic.R
# Purpose: Create a conceptual diagram of the integrated modeling framework
#          for soybean deficit irrigation, showing key components and
#          data flows
# Output: 04_model_schematic.tiff (600 dpi) + 04_model_schematic.png
# ============================================================================

library(ggplot2)
library(gridExtra)

# ============================================================================
# 1. Create model framework schematic
# ============================================================================

# Define model components as boxes
model_components <- data.frame(
  component = c(
    "INPUTS",
    "Weather Data\n(Precip, Temp, Radiation)",
    "Soil Properties\n(Texture, Water Holding Cap.)",
    "Management\n(Irrigation, Planting Date)",
    "SOIL-WATER MODEL",
    "Water Movement\n& Storage",
    "Plant-Available Water\nDynamics",
    "CROP PHYSIOLOGY MODEL",
    "Water Stress Index",
    "Physiological Response\n(Photosynthesis, Growth)",
    "MODEL OUTPUTS",
    "Yield Prediction",
    "Water Use Efficiency",
    "Irrigation Timing\nRecommendations"
  ),
  x = c(
    0.5, 0.25, 0.5, 0.75,
    0.5, 0.25, 0.75,
    0.5, 0.25, 0.75,
    0.5, 0.25, 0.75, 0.5
  ),
  y = c(
    9.5, 8.5, 8.5, 8.5,
    7, 6, 6,
    4.5, 3.5, 3.5,
    2, 1, 1, 0
  ),
  box_type = c(
    "section", "input", "input", "input",
    "section", "process", "process",
    "section", "process", "process",
    "section", "output", "output", "output"
  ),
  color = c(
    "lightgray", "#b3e5fc", "#b3e5fc", "#b3e5fc",
    "lightgray", "#fff9c4", "#fff9c4",
    "lightgray", "#f8bbd0", "#f8bbd0",
    "lightgray", "#c8e6c9", "#c8e6c9", "#c8e6c9"
  )
)

# Create the schematic
schematic <- ggplot(model_components, aes(x = x, y = y)) +
  # Draw boxes
  geom_rect(aes(xmin = x - 0.15, xmax = x + 0.15, ymin = y - 0.3, ymax = y + 0.3,
                fill = color, color = NA),
            size = 0) +
  # Add text labels
  geom_text(aes(label = component),
            size = 3.2, fontface = "bold", color = "#333333") +
  # Draw arrows connecting components
  # Inputs to Soil-Water Model
  annotate("segment", x = 0.25, xend = 0.25, y = 8.2, yend = 6.3,
           arrow = arrow(length = unit(0.15, "cm")), color = "gray40", size = 0.6) +
  annotate("segment", x = 0.5, xend = 0.5, y = 8.2, yend = 6.3,
           arrow = arrow(length = unit(0.15, "cm")), color = "gray40", size = 0.6) +
  annotate("segment", x = 0.75, xend = 0.75, y = 8.2, yend = 6.3,
           arrow = arrow(length = unit(0.15, "cm")), color = "gray40", size = 0.6) +
  # Soil-Water outputs to Crop Physiology
  annotate("segment", x = 0.25, xend = 0.25, y = 5.7, yend = 3.8,
           arrow = arrow(length = unit(0.15, "cm")), color = "gray40", size = 0.6) +
  annotate("segment", x = 0.75, xend = 0.75, y = 5.7, yend = 3.8,
           arrow = arrow(length = unit(0.15, "cm")), color = "gray40", size = 0.6) +
  # Crop Physiology to Outputs
  annotate("segment", x = 0.25, xend = 0.25, y = 3.2, yend = 1.3,
           arrow = arrow(length = unit(0.15, "cm")), color = "gray40", size = 0.6) +
  annotate("segment", x = 0.75, xend = 0.75, y = 3.2, yend = 1.3,
           arrow = arrow(length = unit(0.15, "cm")), color = "gray40", size = 0.6) +
  annotate("segment", x = 0.5, xend = 0.5, y = 3.2, yend = 0.3,
           arrow = arrow(length = unit(0.15, "cm")), color = "gray40", size = 0.6) +
  # Feedback loop from Crop Physiology to Soil-Water
  annotate("segment", x = 0.85, xend = 1, y = 4, yend = 4,
           arrow = arrow(length = unit(0.15, "cm")), color = "gray40", size = 0.5,
           linetype = "dashed") +
  annotate("segment", x = 1, xend = 1, y = 4, yend = 6,
           arrow = arrow(length = unit(0.15, "cm")), color = "gray40", size = 0.5,
           linetype = "dashed") +
  annotate("segment", x = 1, xend = 0.85, y = 6, yend = 6,
           arrow = arrow(length = unit(0.15, "cm")), color = "gray40", size = 0.5,
           linetype = "dashed") +
  annotate("text", x = 1.05, y = 5, label = "Feedback:\nRoot water uptake\nAffects soil water",
           size = 2.5, color = "gray40", fontface = "italic") +
  # Scale and limits
  xlim(-0.1, 1.15) + ylim(-0.5, 10) +
  scale_fill_identity() +
  # Title and styling
  theme_void() +
  theme(
    plot.title = element_text(size = 13, face = "bold", hjust = 0.5, vjust = 1),
    plot.subtitle = element_text(size = 10, color = "#555555", hjust = 0.5)
  ) +
  labs(
    title = "Integrated Modeling Framework for Soybean Deficit Irrigation",
    subtitle = "Multi-component system linking soil physics, crop physiology, and management decisions"
  )

# ============================================================================
# 2. Create model features and improvements panel
# ============================================================================

improvements_text <- data.frame(
  section = c("OBJECTIVE 2:", "OBJECTIVE 3:", "APPLICATIONS:"),
  detail = c(
    "Model Improvement #1:\nEnhance soil-water dynamics module\n• Add macropore flow representation\n• Improve water retention curves\n• Couple with root water uptake",
    "Model Improvement #2:\nImprove crop physiology module\n• Better water stress function\n• Calibrate with field data\n• Link to yield components",
    "Model Applications (Obj. 4-6):\n• Scenario analysis: climate & mgmt\n• Regional vulnerability assessment\n• Policy implications & ROI analysis"
  )
)

improvements <- ggplot(data = improvements_text, aes(x = 1, y = 1)) +
  annotate("text", x = 0.05, y = 0.95,
           label = "RESEARCH OBJECTIVES MAPPED TO FRAMEWORK:",
           fontface = "bold", size = 3.5, hjust = 0, vjust = 1, color = "#1a1a1a") +
  annotate("text", x = 0.05, y = 0.80,
           label = "OBJECTIVE 1: Field Experiments",
           fontface = "bold", size = 3.2, hjust = 0, vjust = 1, color = "#d73027") +
  annotate("text", x = 0.05, y = 0.74,
           label = "• Multi-site experiments to generate data\n• Validate model predictions\n• Measure yield, WUE, soil water, plant water",
           size = 2.9, hjust = 0, vjust = 1) +
  annotate("text", x = 0.05, y = 0.60,
           label = improvements_text$section[1],
           fontface = "bold", size = 3.2, hjust = 0, vjust = 1, color = "#fdae61") +
  annotate("text", x = 0.08, y = 0.54,
           label = "Enhance soil-water module\n• Add macropore flow\n• Improve water retention curves",
           size = 2.9, hjust = 0, vjust = 1) +
  annotate("text", x = 0.05, y = 0.40,
           label = improvements_text$section[2],
           fontface = "bold", size = 3.2, hjust = 0, vjust = 1, color = "#fdae61") +
  annotate("text", x = 0.08, y = 0.34,
           label = "Improve physiology module\n• Better water stress functions\n• Field data calibration",
           size = 2.9, hjust = 0, vjust = 1) +
  annotate("text", x = 0.05, y = 0.20,
           label = improvements_text$section[3],
           fontface = "bold", size = 3.2, hjust = 0, vjust = 1, color = "#91bfdb") +
  annotate("text", x = 0.08, y = 0.14,
           label = "Obj 4: Climate scenarios\nObj 5: Regional assessment\nObj 6: Policy analysis",
           size = 2.9, hjust = 0, vjust = 1) +
  xlim(0, 1) + ylim(0, 1) +
  theme_void()

# ============================================================================
# 3. Combine and save
# ============================================================================

combined <- gridExtra::grid.arrange(schematic, improvements,
                                    nrow = 1, widths = c(1.2, 1))

# Save as TIFF
tiff(filename = "figures/04_model_schematic.tiff",
     width = 13, height = 6.5, units = "in", res = 600, compression = "lzw")
print(combined)
dev.off()

# Save as PNG
png(filename = "figures/04_model_schematic.png",
    width = 13, height = 6.5, units = "in", res = 150)
print(combined)
dev.off()

cat("\n=== Model Schematic Generated ===\n")
cat("TIFF: figures/04_model_schematic.tiff (600 dpi)\n")
cat("PNG:  figures/04_model_schematic.png\n")
