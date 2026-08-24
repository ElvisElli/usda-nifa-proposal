# USDA-NIFA Proposal: Productivity and Sustainability of Soybean Deficit Irrigation

This repository contains a comprehensive USDA-NIFA proposal on soybean deficit irrigation research, including proposal templates, R scripts for publication-quality figures, literature review materials, and project documentation.

## Project Overview

**Title:** Productivity and Sustainability of Soybean Deficit Irrigation in the United States

**Research Focus:** 
- Multi-location field experiments (5 US regions: Nebraska, Iowa, Illinois, Arkansas, Minnesota)
- Process-based crop modeling for deficit irrigation responses
- Physiological characterization of water stress sensitivity by growth stage
- Decision support tool development for farmer adoption
- Duration: 3 years across 5 field research sites

## Repository Structure

```
usda-nifa-proposal/
├── PROJECT_NARRATIVE_TEMPLATE.docx    # Main proposal template (ready to fill in)
├── proposal/
│   ├── PROPOSAL_OUTLINE.docx          # Detailed outline with components
│   ├── PROPOSAL_NARRATIVE.md           # Markdown version of proposal content
│   └── ProjectNarrative-8-24.docx     # Initial proposal draft
├── scripts/                            # R scripts for publication-quality figures
│   ├── 01_study_locations_map.R       # Map showing 5 research locations
│   ├── 02_experimental_design.R       # Experimental design schematic
│   ├── 03_yield_water_response_curve.R # Yield vs water relationships
│   ├── 04_model_schematic.R           # Crop model framework diagram
│   ├── 05_regional_vulnerability.R    # Regional water stress vulnerability
│   ├── 06_cost_benefit_analysis.R     # Economic analysis visualization
│   └── 07_climate_scenarios.R         # Scenario analysis outputs
├── literature-review/
│   └── LITERATURE_REVIEW_SUMMARY.md   # Key literature and citations
├── writing-resources/                  # USDA grant writing guidelines
│   ├── CamScanner 8-24-26 10.14_extracted.txt
│   └── CamScanner 8-24-26 10.14 (1)_extracted.txt
├── past-proposals/                     # Previous funded proposals (reference)
│   ├── ProjectNarrative.pdf
│   ├── ProjectNarrative2.pdf
│   └── ProjectNarrative3.pdf
├── review-relevant-literature/        # Peer-reviewed papers in repository
├── common-criticisms/                 # Reviewer feedback and responses
├── figures/                           # Generated figures and images
├── nofo/                              # USDA NIFA Notice of Funding Opportunity
├── PROJECT_STATUS.xml                 # Project completion tracking
├── PROGRAM_ALIGNMENT.md               # USDA program alignment analysis
└── README.md                          # This file
```

## Using the Proposal Template

### Quick Start

1. **Open the template:** `PROJECT_NARRATIVE_TEMPLATE.docx`

2. **Identify fillable fields:** Yellow-highlighted sections indicate where you need to add specific information

3. **Fill in each section:**
   - **Title:** Already set to deficit irrigation topic (edit if needed)
   - **Introduction/Overview:** Replace highlighted fields with specific statistics and context
   - **Research Objectives:** Customize study sites, methods, and hypotheses
   - **Expected Outcomes:** Detail your specific publications, models, and tools
   - **Potential Problems:** Modify strategies based on your specific challenges
   - **Literature Cited:** Expand with your complete reference list

### Document Structure

The template includes all 5 standard USDA-NIFA proposal sections:

#### 1. **INTRODUCTION**
- Overview subsection with current knowledge, gap analysis, long-term goal, overall objective, and central hypothesis
- Follows USDA writing guidelines with bold/underlined key terms for reviewer navigation

#### 2. **RESEARCH OBJECTIVES & APPROACH**
- **Objective #1:** Field Experiments (Study Sites, Experimental Design, Measurements, Statistical Analysis)
- **Objective #2:** Crop Modeling (Model Selection, Improvements, Validation)
- **Objective #3:** Physiological Functions (Response Functions, Parameterization, Integration)
- **Objective #4:** Decision Tools (Tool Development, Testing, Adoption)
- Each objective includes working hypothesis and detailed subsections

#### 3. **EXPECTED OUTCOMES & DELIVERABLES**
- Scientific outcomes and publications
- Data and models
- Decision support tools
- Extension and training products

#### 4. **POTENTIAL PROBLEMS & ALTERNATIVE STRATEGIES**
- Problem 1: Weather variability & contingency irrigation
- Problem 2: Model complexity & stepwise approach
- Problem 3: Farmer cooperation & incentive programs
- Problem 4: Adoption barriers & economic analysis

#### 5. **LITERATURE CITED**
- Formatted template with example citations
- Supports alphabetical author listing and DOI inclusion

## R Scripts for Figures

All R scripts are configured to generate publication-quality outputs:
- **Format:** TIFF (600 DPI) + PNG formats
- **Purpose:** Create figures for proposal, presentations, and publications
- **Usage:** `Rscript script_name.R` or run in RStudio

### Individual Scripts

1. **01_study_locations_map.R** - Geographic distribution of 5 research sites
2. **02_experimental_design.R** - Randomized block design layout
3. **03_yield_water_response_curve.R** - Yield response to irrigation levels
4. **04_model_schematic.R** - RZWQM2/APSIM model structure diagram
5. **05_regional_vulnerability.R** - Water stress vulnerability by region
6. **06_cost_benefit_analysis.R** - Economic return on investment curves
7. **07_climate_scenarios.R** - Future climate scenario projections

## Key Literature

**Deficit Irrigation in Soybean:**
- Torrion et al. (2014) - Deficit irrigation strategies and yield responses
- Bunce (2016) - Water relations and gas exchange under stress
- Merkle et al. (2013) - Irrigation scheduling in Western Corn Belt

**Water Stress Physiology:**
- Nabati et al. (2011) - Photosynthetic response to water deficit
- Payero & Irmak (2006) - Crop coefficients and evapotranspiration
- Sinclair & Muchow (2001) - Root water dynamics and stress response

**Crop Modeling:**
- Hsiao et al. (2009) - AquaCrop model development
- Ahuja et al. (2011) - RZWQM2 application to crop-water interactions
- Holzworth et al. (2014) - APSIM model framework

## USDA Proposal Writing Guidelines

Key principles from extracted writing materials:

✓ **Component Labels:** Use bold, underline, and italics for reviewer navigation
✓ **Clear Structure:** Title → Overview → Objectives → Methods → Outcomes
✓ **Action-Oriented Verbs:** Establish, Determine, Identify, Develop (not study/examine)
✓ **Hypothesis-Driven:** Include testable hypotheses without conditional words (can, may, might)
✓ **Why Focus:** Emphasize significance and gaps, not just methods
✓ **Key Citations:** Include essential references in author-year format
✓ **Long-Term Goal:** Connect to USDA mission (food security, sustainability)

## Project Status

**Phase 1: COMPLETE**
- ✓ Proposal outline and narrative framework
- ✓ R scripts for publication figures (7 total)
- ✓ Literature review and bibliography
- ✓ Writing guidelines extracted from USDA materials
- ✓ Project status tracking (XML format)

**Phase 2: READY**
- Comprehensive proposal template with fillable fields
- Multi-location field experiment protocols
- Model development specifications
- Decision tool requirements

**Phase 3: READY**
- Field data analysis and interpretation
- Model calibration and validation
- Tool development and testing
- Extension and training materials

## Expected Deliverables

**Scientific Outcomes:**
- 5-7 peer-reviewed publications
- Calibrated crop models (>85% accuracy)
- Validated physiological response functions
- Publicly accessible field datasets

**Tools & Resources:**
- Web-based decision support system
- Mobile app for deficit irrigation scheduling
- Spreadsheet-based planning tool
- Farmer education materials

**Extension & Outreach:**
- Field days at each research location
- Extension bulletins and fact sheets
- Webinars and conference presentations
- On-farm demonstration networks

## Getting Started

1. **Review the template:** Open `PROJECT_NARRATIVE_TEMPLATE.docx`
2. **Check formatting:** Examine `past-proposals/` for style reference
3. **Run R scripts:** Generate figures with `scripts/01_*.R` through `07_*.R`
4. **Consult guidelines:** Review USDA writing principles in `writing-resources/`
5. **Customize content:** Fill in yellow-highlighted sections with your specific information
6. **Expand literature:** Add citations to LITERATURE CITED section
7. **Submit:** Follow USDA-NIFA submission guidelines in NOFO documentation

## File Conventions

- **Proposal documents:** .docx format for editing, .md for version control
- **Figures:** R scripts generate TIFF (600 DPI publication) + PNG (web)
- **Literature:** Peer-reviewed publications with DOI links
- **Status tracking:** XML format for structured project management
- **Writing materials:** OCR-extracted text from scanned PDFs

## Branch Strategy

- **main:** Production-ready proposal components
- **claude/usda-nifa-proposal-8qekcy:** Development branch for ongoing refinement

## Questions & Support

For template customization or technical questions:
- Review `PROGRAM_ALIGNMENT.md` for USDA program specifics
- Check `PROJECT_STATUS.xml` for detailed project timeline
- Refer to `writing-resources/` for USDA proposal writing standards
- Examine `past-proposals/` for formatting and content examples

---

**Last Updated:** August 24, 2026  
**Project Director:** E. Ellis (eelli@uark.edu)  
**Institution:** University of Arkansas Department of Agriculture  
**Program:** USDA-NIFA Foundational Program (Agriculture and Food Research Initiative)
