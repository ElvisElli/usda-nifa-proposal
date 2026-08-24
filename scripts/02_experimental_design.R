#!/usr/bin/env Rscript
# ============================================================================
# Script: 02_experimental_design.R
# Purpose: Visualize experimental design for field studies on soybean
#          deficit irrigation including treatments, replicates, and layout
# Output: 02_experimental_design.tiff (600 dpi) + 02_experimental_design.png
# ============================================================================

library(ggplot2)
library(gridExtra)
library(dplyr)

# ============================================================================
# 1. Define experimental treatments
# ============================================================================

# Deficit irrigation treatments based on seasonal water availability
treatments <- data.frame(
  treatment_id = 1:4,
  treatment_name = c(
    "Full Irrigation (FI)",
    "Mild Deficit (RDI-50%)",
    "Severe Deficit (RDI-25%)",
    Rainfed = "Rainfed"
  ),
  water_applied_mm = c(250, 125, 63, 0),
  irrigation_events = c(6, 3, 2, 0),
  expected_yield_reduction = c("0%", "5-10%", "15-25%", "30-40%")
)

# Experimental design parameters
n_replicates <- 4
block_size <- 4  # 4 treatments per block
plot_size_m2 <- 20  # meters squared per plot

# ============================================================================
# 2. Create field layout diagram
# ============================================================================

# Generate randomized block design
set.seed(42)  # For reproducibility
n_blocks <- 3

field_layout <- data.frame()
for (block in 1:n_blocks) {
  # Randomize treatment assignments
  block_treatments <- sample(1:4, 4, replace = FALSE)

  for (plot in 1:4) {
    treatment <- block_treatments[plot]
    field_layout <- rbind(field_layout, data.frame(
      block = block,
      plot = plot,
      treatment_id = treatment,
      x = plot - 0.5,
      y = block - 0.5
    ))
  }
}

# Add treatment names
field_layout <- left_join(field_layout,
                         treatments[, c("treatment_id", "treatment_name")],
                         by = "treatment_id")

# Create field layout visualization
field_plot <- ggplot(field_layout, aes(x = x, y = y, fill = treatment_name)) +
  geom_tile(color = "black", size = 1) +
  geom_text(aes(label = paste0("T", treatment_id)),
            size = 5, fontface = "bold", color = "white") +
  scale_fill_brewer(palette = "Set2", name = "Treatment") +
  scale_x_continuous(breaks = 0.5:3.5, labels = 1:4) +
  scale_y_continuous(breaks = 0.5:2.5, labels = 3:1) +
  coord_fixed() +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 13, face = "bold", hjust = 0.5),
    axis.title = element_text(size = 11, face = "bold"),
    axis.text = element_text(size = 10),
    legend.position = "bottom",
    legend.text = element_text(size = 9),
    plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm")
  ) +
  labs(
    title = "Randomized Complete Block Design (RCBD)",
    subtitle = "3 blocks × 4 treatments × 4 replicates = 48 plots",
    x = "Plot Number",
    y = "Block Number"
  )

# ============================================================================
# 3. Create treatment summary table
# ============================================================================

treatment_summary <- ggplot(data = treatments, aes(x = 1, y = 1)) +
  annotate("text", x = 0.05, y = 0.95,
           label = "TREATMENT SPECIFICATIONS",
           fontface = "bold", size = 4.5, hjust = 0, vjust = 1) +
  annotate("text", x = 0.05, y = 0.88,
           label = "Treatment | Applied Water | Events | Yield Loss",
           fontface = "bold", size = 3.5, hjust = 0, vjust = 1,
           family = "monospace") +
  annotate("text", x = 0.05, y = 0.80,
           label = "FI        | 250 mm        | 6     | ~0%",
           size = 3.5, hjust = 0, vjust = 1, family = "monospace") +
  annotate("text", x = 0.05, y = 0.73,
           label = "RDI-50%   | 125 mm        | 3     | 5-10%",
           size = 3.5, hjust = 0, vjust = 1, family = "monospace") +
  annotate("text", x = 0.05, y = 0.66,
           label = "RDI-25%   | 63 mm         | 2     | 15-25%",
           size = 3.5, hjust = 0, vjust = 1, family = "monospace") +
  annotate("text", x = 0.05, y = 0.59,
           label = "Rainfed   | 0 mm          | 0     | 30-40%",
           size = 3.5, hjust = 0, vjust = 1, family = "monospace") +
  annotate("text", x = 0.05, y = 0.48,
           label = "KEY DESIGN PARAMETERS:",
           fontface = "bold", size = 3.5, hjust = 0, vjust = 1) +
  annotate("text", x = 0.05, y = 0.41,
           label = paste("• Replicates per treatment:", n_replicates),
           size = 3.2, hjust = 0, vjust = 1) +
  annotate("text", x = 0.05, y = 0.35,
           label = paste("• Plot size:", plot_size_m2, "m² (4m × 5m)"),
           size = 3.2, hjust = 0, vjust = 1) +
  annotate("text", x = 0.05, y = 0.29,
           label = paste("• Total blocks:", n_blocks),
           size = 3.2, hjust = 0, vjust = 1) +
  annotate("text", x = 0.05, y = 0.23,
           label = "• Irrigation system: Drip with soil moisture sensors",
           size = 3.2, hjust = 0, vjust = 1) +
  annotate("text", x = 0.05, y = 0.17,
           label = "• Measurements: Yield, WUE, physiological responses",
           size = 3.2, hjust = 0, vjust = 1) +
  xlim(0, 1) + ylim(0, 1) +
  theme_void()

# ============================================================================
# 4. Combine and save
# ============================================================================

combined <- gridExtra::grid.arrange(field_plot, treatment_summary,
                                    nrow = 1, widths = c(1, 1.3))

# Save as TIFF
tiff(filename = "figures/02_experimental_design.tiff",
     width = 12, height = 5, units = "in", res = 600, compression = "lzw")
print(combined)
dev.off()

# Save as PNG
png(filename = "figures/02_experimental_design.png",
    width = 12, height = 5, units = "in", res = 150)
print(combined)
dev.off()

cat("\n=== Experimental Design Diagram Generated ===\n")
cat("TIFF: figures/02_experimental_design.tiff (600 dpi)\n")
cat("PNG:  figures/02_experimental_design.png\n")
