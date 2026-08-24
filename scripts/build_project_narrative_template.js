const fs = require("fs");
const {
  Document, Packer, Paragraph, TextRun, AlignmentType, HeadingLevel,
  Header, PageNumber, Table, TableRow, TableCell, WidthType, ShadingType,
  BorderStyle,
} = require("docx");

const FONT = "Times New Roman";
const SZ = 24; // 12pt in half-points

/* ---------- run helpers ---------- */
const t = (text, opts = {}) => new TextRun({ text, font: FONT, size: SZ, ...opts });
const b = (text) => t(text, { bold: true });
const bi = (text) => t(text, { bold: true, italics: true });
const it = (text) => t(text, { italics: true });
// yellow-highlighted fillable field
const f = (text) => t(text, { highlight: "yellow", italics: true });

/* ---------- paragraph helpers ---------- */
const SPACE_BEFORE = { before: 200, after: 60 };

// MAJOR SECTION — bold, ALL CAPS
const H1 = (text) =>
  new Paragraph({ spacing: SPACE_BEFORE, children: [b(text)] });

// Subsection — bold, title case
const H2 = (text) =>
  new Paragraph({ spacing: { before: 160, after: 40 }, children: [b(text)] });

// Sub-subsection — bold italic, standalone
const H3 = (text) =>
  new Paragraph({ spacing: { before: 140, after: 40 }, children: [bi(text)] });

// Standalone bold objective heading (used inside APPROACH)
const OBJ = (text) =>
  new Paragraph({
    spacing: { before: 220, after: 60 },
    alignment: AlignmentType.JUSTIFIED,
    children: [b(text)],
  });

// Body paragraph, justified. indent=true adds first-line indent.
const p = (children, indent = true) =>
  new Paragraph({
    alignment: AlignmentType.JUSTIFIED,
    spacing: { after: 60, line: 240 },
    indent: indent ? { firstLine: 360 } : undefined,
    children,
  });

// Run-in heading paragraph: bold-italic label, then regular body in same paragraph
const runIn = (label, children) =>
  new Paragraph({
    alignment: AlignmentType.JUSTIFIED,
    spacing: { before: 120, after: 60, line: 240 },
    children: [bi(label), ...children],
  });

// Guidance note (fully highlighted instructional line)
const note = (text) =>
  new Paragraph({
    alignment: AlignmentType.LEFT,
    spacing: { after: 60 },
    indent: { left: 360 },
    children: [f(text)],
  });

// Figure caption placeholder
const figure = (num, caption) =>
  new Paragraph({
    alignment: AlignmentType.LEFT,
    spacing: { before: 120, after: 120 },
    children: [
      f(`[INSERT FIGURE ${num} HERE]`),
      t(" "),
      b(`Figure ${num}. `),
      f(caption),
    ],
  });

const blank = () => new Paragraph({ children: [t("")] });

/* ================= DOCUMENT CONTENT ================= */
const children = [];

children.push(
  new Paragraph({
    alignment: AlignmentType.LEFT,
    spacing: { after: 240 },
    children: [b("PRODUCTIVITY AND SUSTAINABILITY OF SOYBEAN DEFICIT IRRIGATION IN THE UNITED STATES")],
  })
);

/* ---------------- INTRODUCTION ---------------- */
children.push(H1("INTRODUCTION"));
children.push(H2("Overview"));

// Paragraph 1: hook / current knowledge / gap / need / consequences
children.push(
  p([
    f("[HOOK — one sentence that simultaneously (a) creates a contrast, conundrum, paradox, or striking quantification, (b) names the specific problem this proposal addresses, and (c) uses words from the program priority area you are targeting. Avoid generic openers.]"),
    t(" Irrigated soybean accounts for approximately "),
    f("[INSERT % of U.S. soybean area and volume of water applied annually, with citation]"),
    t(", yet aquifer decline in the Mid-South and High Plains is progressively removing the water supply on which that productivity depends ("),
    f("[cite]"),
    t("). Deficit irrigation — the deliberate application of less water than full crop evapotranspiration demand during periods when the crop is least sensitive — has been shown to maintain yield while reducing seasonal water use in "),
    f("[cite crops/systems where this is established: maize, wheat, cotton]"),
    t(". In soybean, "),
    f("[CURRENT KNOWLEDGE — 4 to 5 carefully written sentences giving reviewers a snapshot of the scientific landscape: what is known about growth-stage sensitivity to water deficit, what irrigation scheduling tools currently exist, and what your own prior work has contributed. Key citations only, author/year format.]"),
    t(" However, "),
    f("[GAP IN THE KNOWLEDGE BASE / LACK OF SOMETHING — one simple, direct sentence naming the specific gap that drives this project and that links back to the current-knowledge sentences above.]"),
    t(" Therefore, there is a critical need to "),
    f("[STATEMENT OF NEED — a higher-level, conceptual version of the gap statement; what explicitly is needed to take the next step]"),
    t(". In the absence of this knowledge, "),
    f("[CONSEQUENCES OF NOT MEETING THE NEED — what program-relevant problem will be created, exacerbated, or allowed to persist; fold in key words from the program priority description]"),
    t("."),
  ], false)
);

// Paragraph 2: What, Why, Who
children.push(
  p([
    t("Our "),
    t("long-term goal", { }),
    t(" is to help stakeholders in U.S. agriculture "),
    f("[LONG-TERM GOAL — the big picture of your research program, broad enough to encompass the need above, relevant to the USDA mission, and realistic; it should be in concert with the purpose of the program priority area]"),
    t(". Our "),
    t("overall objective"),
    t(" in this application is to "),
    f("[OVERALL OBJECTIVE — a conceptual paraphrase of your critical need statement that fits under the umbrella of the long-term goal; use an action verb such as determine, identify, establish, quantify, or develop]"),
    t(". Our "),
    t("central hypothesis"),
    t(" is that "),
    f("[CENTRAL HYPOTHESIS — what must be objectively tested in order to attain the overall objective; craft it so that its parts map one-to-one onto the specific objectives below]"),
    t(". This hypothesis is based on our preliminary data showing "),
    f("[HOW FORMULATED — the preliminary/prior findings from your own team that led you to this hypothesis; reference the figures in Preliminary Results]"),
    t(", and is complemented by published findings that "),
    f("[supporting literature]"),
    t(". Our combined expertise in soybean physiology, irrigation management, and cropping systems modeling makes us the ideal team to "),
    f("[TEAM QUALIFICATIONS — why this team, specifically, is prepared to do this work]"),
    t(". We propose the following objectives:"),
  ])
);

// Specific objectives with working hypotheses — bold label only
children.push(
  p([
    b("Objective #1"),
    t(": Quantify soybean yield, water use, and physiological responses to deficit irrigation across contrasting production environments. "),
    t("Working hypothesis – "),
    f("[WORKING HYPOTHESIS 1 — a focused, testable statement at the mechanistic level; no conditional words such as may, might, or could. Immediately follow it with the preliminary finding that supports it.]"),
    t(" ("),
    f("[cite]"),
    t(")."),
  ], false)
);
children.push(
  p([
    b("Objective #2"),
    t(": Improve the capability of a process-based cropping systems model to simulate soybean growth, water use, and yield formation under deficit irrigation. "),
    t("Working hypothesis – "),
    f("[WORKING HYPOTHESIS 2 — what specifically will change in model behavior once the new algorithms and genotype-specific parameters are implemented, and by how much]"),
    t(" ("),
    f("[cite]"),
    t(")."),
  ], false)
);
children.push(
  p([
    b("Objective #3"),
    t(": Identify deficit irrigation strategies that maximize productivity and water use efficiency for target environments. "),
    t("Working hypothesis – "),
    f("[WORKING HYPOTHESIS 3 — the specific management/environment combination you expect to be optimal, and the tradeoff you expect to constrain it]"),
    t(" ("),
    f("[cite]"),
    t(")."),
  ], false)
);

// Fundamental rationale
children.push(
  p([
    t("The fundamental rationale of the proposed project is that once "),
    f("[what will exist at the end of the project — e.g., our physiological dataset and improved deficit-irrigation modeling framework are created and tested]"),
    t(", we can "),
    f("[what that enables — e.g., identify growth-stage-specific irrigation thresholds that sustain yield while reducing withdrawals, providing opportunities to extend the productive life of the aquifer]"),
    t("."),
  ])
);

// Paragraph 4: Payoff — innovation, expected outcomes, impact
children.push(
  p([
    t("The proposed research is innovative because, while conventional approaches "),
    f("[what is conventionally done — e.g., evaluate deficit irrigation empirically at single sites and single seasons]"),
    t(", we propose to "),
    f("[INNOVATION — the sharp contrast: what you will do that is meaningfully different, whether a new approach, a new conceptualization, or theory imported from another discipline]"),
    t(". Upon completion of this project, we will deliver: (1) "),
    f("[EXPECTED OUTCOME tied to Objective #1]"),
    t(", (2) "),
    f("[EXPECTED OUTCOME tied to Objective #2]"),
    t(", and (3) "),
    f("[EXPECTED OUTCOME tied to Objective #3]"),
    t(". These outcomes are expected to have an important positive impact because "),
    f("[IMPACT — written at a general level: how the expected outcomes will advance the field and contribute to solving the agriculturally important problem raised in the first paragraph; make it congruent with the program priority description]"),
    t("."),
  ])
);

/* ---------------- Review of Relevant Literature ---------------- */
children.push(H2("Review of Relevant Literature"));
children.push(
  note("Organize this subsection under 2–4 thematic bold-italic headings phrased as needs or problems (as in your previous proposals: “The need for …”), not as a chronological list of papers. Each theme should end by pointing at the gap your objectives fill.")
);

children.push(H3("The need to quantify growth-stage-specific sensitivity of soybean to water deficit"));
children.push(
  p([
    f("[Synthesize what is known about soybean response to water deficit by growth stage (vegetative, R1–R3, R4–R5, R5–R7), including the magnitude of yield loss reported per stage and the physiological basis — stomatal closure, reduced radiation interception, pod abortion, shortened seed fill. State clearly what is inconsistent or unresolved across studies, and why single-site studies have not resolved it.]"),
  ], false)
);
children.push(
  p([
    f("[Close the theme with an explicit statement of what remains unknown and how Objective #1 addresses it.]"),
  ])
);

children.push(H3("The need for improved representation of water-limited soybean growth in cropping systems models"));
children.push(
  p([
    f("[Describe the cropping systems model you will use (e.g., APSIM Next Generation, RZWQM2, DSSAT/CROPGRO) and why. Follow the pattern you used previously: (a) the model has proven robust for soybean across U.S. production systems, with citations; (b) the current model version offers script flexibility for extending capability; (c) publication/citation metrics demonstrating adoption; and (d) PI/Co-PI experience calibrating and applying the framework.]"),
  ], false)
);
children.push(
  p([
    f("[Then state the specific limitation under water deficit — e.g., simplified soil water extraction and root distribution, absence of a hydraulic-limitation or VPD-response function, fixed harvest index under stress — and the consequence for prediction. Close by pointing at Objective #2.]"),
  ])
);

children.push(H3("The need for environment-specific deficit irrigation recommendations"));
children.push(
  p([
    f("[Review existing irrigation scheduling tools and thresholds available to producers (e.g., Arkansas Irrigation Scheduler, checkbook methods, soil-moisture-sensor thresholds), what they do well, and why they do not currently support intentional deficit strategies. Note the genotype × environment × management interaction that makes single-recommendation approaches fail, and point at Objective #3.]"),
  ], false)
);

/* ---------------- Preliminary Results ---------------- */
children.push(H2("Preliminary Results"));
children.push(
  note("Reviewers weight this subsection heavily. Present your own data as evidence that (a) the central hypothesis is plausible, (b) the methods are feasible in your hands, and (c) the team can complete the work on schedule. Reference each figure explicitly in the text.")
);
children.push(
  p([
    f("[PRELIMINARY FIELD DATA — describe the site(s), year(s), design, treatments, and measurements already completed. Report the observed range in yield and water use, and interpret what it implies for the central hypothesis.]"),
  ], false)
);
children.push(figure(1, "[Caption: observed soybean yield and water use efficiency response to irrigation treatments at INSERT SITE, INSERT YEAR.]"));
children.push(
  p([
    f("[PRELIMINARY SIMULATION EXERCISE — as in your previous proposals, present an in-silico analysis that supports the central hypothesis and reveals the key interaction you propose to resolve. State the model, location, weather record length, and scenarios evaluated.]"),
  ], false)
);
children.push(figure(2, "[Caption: simulated soybean yield and seasonal irrigation response to deficit irrigation thresholds imposed at different growth stages, INSERT LOCATION, averaged across INSERT N weather years.]"));
children.push(
  p([
    t("Our preliminary results demonstrate: 1) "),
    f("[what the field data establish]"),
    t(", 2) "),
    f("[what the simulation establishes and what interaction it exposes]"),
    t(", and 3) "),
    f("[what remains unquantified and therefore motivates the proposed work]"),
    t(". These findings provide the rationale for our proposed work to "),
    f("[restate the overall objective in one clause]"),
    t("."),
  ])
);
children.push(
  p([
    f("[TEAM CAPACITY — as in your previous proposals, add a short paragraph documenting the infrastructure and datasets already in hand: research station access, irrigation infrastructure, lysimeters or soil moisture sensor networks, weather stations, seed availability, and computing resources. This establishes that the timeline is realistic.]"),
  ], false)
);

/* ---------------- RATIONALE AND SIGNIFICANCE ---------------- */
children.push(H1("RATIONALE AND SIGNIFICANCE"));
children.push(H3("Rationale"));
children.push(
  p([
    t("Our rationale is that "),
    f("[what the new knowledge will enable stakeholders to do that they cannot do now — expressed as a consequence, not as a restatement of the objectives]"),
    t(". This new knowledge will "),
    f("[the downstream benefit: improved scheduling decisions, extended aquifer life, maintained profitability under allocation limits]"),
    t(", ultimately "),
    f("[the ultimate payoff, phrased to echo the long-term goal]"),
    t("."),
  ], false)
);
children.push(
  p([
    t("Our proposal addresses the program "),
    f("[INSERT EXACT PROGRAM PRIORITY AREA NAME FROM THE NOFO]"),
    t(" by "),
    f("[how the work supports that program's stated purpose]"),
    t(". Our proposal addresses the key requirements including: (1) "),
    f("[requirement quoted or paraphrased from the NOFO]"),
    t(", (2) "),
    f("[requirement]"),
    t(", (3) "),
    f("[requirement]"),
    t(", and (4) "),
    f("[requirement]"),
    t(". We address the priority area of "),
    f("[priority area]"),
    t(" by "),
    f("[the specific activity in your approach that satisfies it]"),
    t("."),
  ])
);
children.push(
  note("If the NOFO instructs that novel ideas or contributions be discussed in Rationale and Significance, move the innovation statement from the Overview payoff paragraph to here.")
);

children.push(H3("Significance"));
children.push(
  p([
    f("[Open by restating the problem and why current understanding is insufficient — this substantiates the general impact statement you made at the end of the Overview.]"),
    t(" Our contribution is significant because "),
    f("[what the new knowledge changes for the field or for stakeholders]"),
    t(". In the short term, "),
    f("[what producers, extension personnel, and irrigation districts can adopt within the project period]"),
    t(". In the long term, we expect "),
    f("[the durable change: sustained productivity under declining water availability, reduced withdrawals per unit of production]"),
    t("."),
  ], false)
);

/* ---------------- APPROACH ---------------- */
children.push(H1("APPROACH"));
children.push(
  p([
    t("The proposed approach involves three major steps: 1) "),
    f("[step 1 — conduct multi-environment field experiments to quantify yield, water use, and physiological response to deficit irrigation imposed at defined growth stages]"),
    t(", 2) "),
    f("[step 2 — implement and parameterize improved water-deficit algorithms within the cropping systems model using the data from step 1]"),
    t(", and 3) "),
    f("[step 3 — apply the improved framework in long-term scenario analysis to identify deficit irrigation strategies for target environments]"),
    t(" ("),
    b("Figure 3"),
    t(")."),
  ], false)
);
children.push(figure(3, "[Caption: objectives and main deliverables for developing and applying an improved deficit irrigation framework for soybean.]"));

/* ---- Objective 1 ---- */
children.push(OBJ("Objective #1: Quantify soybean yield, water use, and physiological responses to deficit irrigation across contrasting production environments"));
children.push(
  runIn("Introduction.", [
    t(" "),
    f("[Open with what previous research has shown and what it has left unresolved — one or two sentences, mirroring the Review of Relevant Literature but not repeating it.]"),
    t(" Our goal here is to "),
    f("[goal of this objective]"),
    t(". Our working hypothesis is that "),
    f("[restate working hypothesis 1]"),
    t(". To test our working hypothesis, we will "),
    f("[preview of Task 1.1]"),
    t(" (task 1.1), and "),
    f("[preview of Task 1.2]"),
    t(" (task 1.2). New knowledge will lead to "),
    f("[what becomes knowable]"),
    t(". The absence of this knowledge limits our ability to "),
    f("[what cannot currently be done]"),
    t(". Upon completion of this objective, we will generate "),
    f("[the concrete deliverable — dataset, coefficients, response functions]"),
    t(". This result is expected to make a positive impact because "),
    f("[why it matters]"),
    t("."),
  ])
);
children.push(
  runIn("Task 1.1: ", [
    bi("[Task title — e.g., Establish multi-environment deficit irrigation experiments]. "),
    f("[Specify: years of the project in which the task occurs; sites and why they were selected (climate gradient, soil texture contrast, aquifer status); cultivars/maturity groups and why; experimental design and number of replications; plot dimensions and row spacing; target plant density; the exact irrigation treatments, including the growth stages at which deficit is imposed and the soil water depletion threshold that triggers irrigation; the irrigation delivery method and how applied depth is measured; and the total number of plots per site per year. State the rationale for each choice, as reviewers assess feasibility here.]"),
  ])
);
children.push(
  runIn("Task 1.2: ", [
    bi("[Task title — e.g., Phenotype crop growth, water use, and physiological status]. "),
    f("[Specify the measurement protocol: phenological staging scale and observation frequency; soil water monitoring depth increments and instrument; seasonal evapotranspiration determination method (soil water balance, lysimeter, eddy covariance, or sap flow); leaf-level gas exchange and water potential measurements, including instrument, time of day, and sampling frequency; canopy measurements including LAI and any UAV/proximal sensing platform and sensors; biomass sampling stages and processing; and final yield determination and moisture correction. Name the software and statistical model used for analysis.]"),
  ])
);
children.push(
  runIn("Expected results from objective 1. ", [
    f("[State what will exist at the end of the objective and quantify the expected outcome where possible: the expected range of yield reduction per unit of water withheld at each growth stage, the expected water use efficiency response, and the precision you expect. Say explicitly what you expect to find and on what basis you expect it.]"),
  ])
);
children.push(
  runIn("Potential Pitfalls and Alternative Strategies. ", [
    f("[Name the credible risks — a wet season that prevents imposition of the deficit treatment, equipment or sensor failure, hail or storm damage, delayed planting — and state the specific design feature that provides resilience (multiple sites, multiple years, rainout shelters, backup instrumentation). Then give the alternative strategy that still allows the objective to be attained.]"),
  ])
);

/* ---- Objective 2 ---- */
children.push(OBJ("Objective #2: Improve the capability of a process-based cropping systems model to simulate soybean growth, water use, and yield formation under deficit irrigation"));
children.push(
  runIn("Introduction.", [
    t(" "),
    f("[State the specific modeling limitation that currently prevents reliable simulation of deficit irrigation, and why it matters.]"),
    t(" Our goal here is to "),
    f("[goal of this objective]"),
    t(". Our working hypothesis is that "),
    f("[restate working hypothesis 2]"),
    t(". We will test our hypothesis through two major tasks: 1) "),
    f("[task 2.1 in one clause]"),
    t(", and 2) "),
    f("[task 2.2 in one clause]"),
    t(". The new knowledge obtained here will lead to "),
    f("[what the improved model makes possible]"),
    t("."),
  ])
);
children.push(
  runIn("Task 2.1: ", [
    bi("[Task title — e.g., Derive and implement water-deficit response functions]. "),
    f("[Describe the model and version. Present the governing equations you will modify (e.g., the soil water supply/demand ratio driving the stress factor, the transpiration response to VPD, the root water extraction front) and define every term and unit — your previous proposals included a numbered equation and a parameter table, and reviewers respond well to that. Explain how the Objective #1 data will be used to parameterize each function, and which parameters will be optimized versus held constant, with justification.]"),
  ])
);
children.push(
  runIn("Task 2.2: ", [
    bi("[Task title — e.g., Calibrate, validate, and benchmark the improved model]. "),
    f("[State the calibration procedure and optimization algorithm, the software packages used, and the weather, soil, and management inputs required. Specify the cross-validation scheme — which site-years calibrate and which validate. Name the performance statistics (RMSE, relative RMSE, Nash–Sutcliffe efficiency, index of agreement) and the acceptance thresholds you will hold yourself to. Describe the benchmark comparison against the unmodified model version.]"),
  ])
);
children.push(
  note("Insert a parameter table here (as in your previous proposals): Category | Parameter | Definition | Unit | Typical value or range."));
children.push(
  runIn("Expected results from objective 2. ", [
    f("[State the expected improvement in prediction accuracy in quantitative terms relative to the unmodified model, name the model version that will be released, and state where the code and parameters will be deposited.]"),
  ])
);
children.push(
  runIn("Potential Pitfalls and Alternative Strategies. ", [
    f("[Address the credible modeling risks: the improved functions may not outperform the existing ones across all environments; parameter equifinality; computational cost of optimization. Give the fallback — restricting the parameter set, using a simpler response function, or applying high-performance computing resources — and name the computing resource available to you.]"),
  ])
);

/* ---- Objective 3 ---- */
children.push(OBJ("Objective #3: Identify deficit irrigation strategies that maximize productivity and water use efficiency for target environments"));
children.push(
  runIn("Introduction.", [
    t(" "),
    f("[Explain why long-term simulation is required to answer this question — that a small number of field seasons cannot sample the weather variability that determines whether a deficit strategy is safe.]"),
    t(" Our goal here is to "),
    f("[goal of this objective]"),
    t(". Our working hypothesis is that "),
    f("[restate working hypothesis 3]"),
    t(". We will test our hypothesis through "),
    f("[number]"),
    t(" tasks. Upon completion of this objective, we will deliver "),
    f("[the decision-relevant product]"),
    t("."),
  ])
);
children.push(
  runIn("Task 3.1: ", [
    bi("[Task title — e.g., Construct long-term scenario analysis across target environments]. "),
    f("[Specify the simulation domain: locations or grid, length of the historical weather record, soil profiles and their source database, cultivar maturity groups, planting date windows, and plant densities. Define the full factorial of deficit irrigation strategies to be evaluated — growth stages, depletion thresholds, and seasonal allocation limits. State the total number of simulations and how they will be executed.]"),
  ])
);
children.push(
  runIn("Task 3.2: ", [
    bi("[Task title — e.g., Identify optimal strategies and quantify risk]. "),
    f("[Define the performance metrics: mean yield, yield stability across years, seasonal irrigation applied, water use efficiency, irrigation water productivity, and net return using the enterprise budget assumptions you specify. Describe how tradeoffs will be evaluated and how downside risk will be reported — for example, the probability of yield loss exceeding a defined threshold. Name the statistical and visualization approach and the software used.]"),
  ])
);
children.push(
  runIn("Task 3.3: ", [
    bi("[Task title — e.g., Deliver results to producers through an accessible interface]. "),
    f("[As in your previous proposals, describe the R-Shiny or equivalent web interface: inputs the user provides, outputs returned, hosting arrangement, and how it will be maintained beyond the project period. Describe stakeholder testing and the feedback mechanism.]"),
  ])
);
children.push(
  runIn("Expected results from objective 3. ", [
    f("[State the expected deliverable in concrete terms — e.g., environment-specific deficit irrigation thresholds and the expected water savings and yield outcome associated with each — and state the expected magnitude where your preliminary simulation supports one.]"),
  ])
);
children.push(
  runIn("Potential Pitfalls and Alternative Strategies. ", [
    f("[Address the risks: the optimal strategy may prove environment-specific to the point of limiting generalization; economic assumptions may shift; the interface may see limited adoption. Give the alternative strategy for each.]"),
  ])
);

/* ---------------- Closing sections ---------------- */
children.push(H3("Sustainability and Data Management Plan"));
children.push(
  p([
    f("[State where data will be archived and under what identifiers — include the USDA Ag Data Commons and any institutional repository — the format and metadata standard, the release timeline relative to publication, and how the model code and the decision interface will be maintained after the award period.]"),
  ], false)
);

children.push(H3("Dissemination of Results and Future Directions"));
children.push(
  p([
    f("[Name the peer-reviewed journals targeted and the approximate number of manuscripts; the scientific meetings; the extension channels — field days, county agent training, irrigation district meetings, fact sheets through your Agricultural Experiment Station's communications service; and the audiences and numbers you expect to reach. Close with the next research questions this work sets up.]"),
  ], false)
);

children.push(H2("Project Timetable"));
children.push(
  new Paragraph({
    alignment: AlignmentType.JUSTIFIED,
    spacing: { after: 120 },
    children: [
      f("[Adjust rows to match your final tasks and shade the cells corresponding to active periods.]"),
    ],
  })
);

/* Timetable table */
const COL = [3600, 1620, 1620, 1620, 1620];
const TOTAL = COL.reduce((a, c) => a + c, 0);
const cell = (children, width, shaded = false) =>
  new TableCell({
    width: { size: width, type: WidthType.DXA },
    shading: shaded
      ? { type: ShadingType.CLEAR, fill: "D9D9D9", color: "auto" }
      : undefined,
    children,
  });
const cellText = (text, width, opts = {}) =>
  cell(
    [new Paragraph({ spacing: { before: 20, after: 20 }, children: [t(text, opts)] })],
    width
  );

const headerRow = new TableRow({
  tableHeader: true,
  children: [
    cell([new Paragraph({ spacing: { before: 20, after: 20 }, children: [b("Task")] })], COL[0], true),
    ...["Year 1", "Year 2", "Year 3", "Year 4"].map((h, i) =>
      cell([new Paragraph({ alignment: AlignmentType.CENTER, spacing: { before: 20, after: 20 }, children: [b(h)] })], COL[i + 1], true)
    ),
  ],
});

const taskRows = [
  "Task 1.1  [title]",
  "Task 1.2  [title]",
  "Task 2.1  [title]",
  "Task 2.2  [title]",
  "Task 3.1  [title]",
  "Task 3.2  [title]",
  "Task 3.3  [title]",
  "Publications, extension, and reporting",
].map((label) =>
  new TableRow({
    children: [
      cellText(label, COL[0]),
      ...[1, 2, 3, 4].map((i) => cellText("", COL[i])),
    ],
  })
);

children.push(
  new Table({
    columnWidths: COL,
    width: { size: TOTAL, type: WidthType.DXA },
    rows: [headerRow, ...taskRows],
  })
);

/* ---------------- Literature Cited ---------------- */
children.push(H1("LITERATURE CITED"));
children.push(
  p([
    f("[Alphabetical by first author, author/year (not numbered) citation style as used in your previous proposals. Confirm the page limit treatment of this section in the NOFO before finalizing.]"),
  ], false)
);

/* ================= BUILD ================= */
const doc = new Document({
  styles: {
    default: {
      document: { run: { font: FONT, size: SZ } },
    },
  },
  sections: [
    {
      properties: {
        page: {
          size: { width: 12240, height: 15840 }, // US Letter
          margin: { top: 1440, right: 1440, bottom: 1440, left: 1440 },
        },
      },
      headers: {
        default: new Header({
          children: [
            new Paragraph({
              alignment: AlignmentType.RIGHT,
              children: [t("Project Narrative")],
            }),
          ],
        }),
      },
      children,
    },
  ],
});

Packer.toBuffer(doc).then((buf) => {
  fs.writeFileSync(process.argv[2], buf);
  console.log("wrote", process.argv[2]);
});
