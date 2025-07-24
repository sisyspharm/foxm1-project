# FOXM1 Figure MATLAB Analysis Code

**_FOXM1 Figure Index 6_**  
_For Manuscript Figures_  
**Latest Update:** 2025-06-11 15:55:00  

---

## Figure 1  
**1D: Cell TMP concentration**  
- **Script:** `tmpvalidate_plot_fitted.m`  
- **Description:** Plots whole-cell intensity vs. time for no treatment and four TMP concentrations, with fitted curves.  

**1E: TMP Reversibility**  
- **Script:** `fluctuationtmp_plot_v2.m`  
- **Description:** Plots nuclear/cytoplasmic ratio vs. time for 4 µM TMP removal vs. non-removal, fits an exponential decay, and computes half-life.  

---

## Figure 2  
**2D: Similarity dynamics of FOXM1 sensor**  
- **Scripts:** `cct_collectdata.m`, `cct_plot_cct_foxm1.m`  
- **Description:** Generates “wanderlust” plots comparing nuclear intensity across parental, FOXM1 sensor, and DHFR sensor cell lines.  

**2E: FOXM1 trajectories – TMP effect**  
- **Script:** `cct_plot_cct_foxm1.m`  
- **Description:** Compares DHFR sensor nuclear intensity trajectories ± TMP.  

**2F: Synchronization effect on FOXM1 dynamics**  
- **Script:** `fitparams_cycif_plot_bar_time12.m`  
- **Description:** Bar graph of cell-cycle phase distribution at 6 h under serum starvation, nocodazole, and untreated conditions.  

**2G: Synchronization effect – treatment comparison**  
- **Script:** `fitparams_plot_compare_treatment_with_tmp.m`  
- **Description:** Plots nuclear intensity vs. time for serum starvation, nocodazole, and untreated ± TMP.  

---

## Figure 3  
**3C: Synthesis ratio G2/G1**  
- **Script:** `fitparams_plot_mg132.m`  
- **Description:** Plots intensity vs. time and fits slope under MG132 treatment.  

**3D: Degradation ratio G2/G1**  
- **Script:** `fitparams_plot_chx_tmp4uM.m`  
- **Description:** Plots intensity vs. time and fits slope under CHX ± TMP.  

**3F: Translocation ratio G2/G1**  
- **Script:** `simulate_model_g1g2.m`  
- **Description:** Simulates and plots intensity vs. time for model predictions vs. single-cell data.  

**3G: Translocation ratio G2/G1** (repeat of 3F)  
- **Script:** `simulate_model_g1g2.m`  

**3H: G1–G2 transition simulation**  
- **Script:** `simulate_model_transition.m`  
- **Description:** Compares simulated transition dynamics with single-cell tracking data.  

---

## Figure 4  
**4B: Single-cell dividing time details**  
- **Script:** `plot_details_diving_time.m`  
- **Description:** Scatter plot of individual cell division times under each treatment.  

**4C: First dividing time**  
- **Script:** `plot_box_diving_time.m`  
- **Description:** Box plot of mitotic phase onset times for no TMP vs. +TMP and across synchronization treatments (G1, S, G2/M).  

**4D: Percent cell dividing**  
- **Script:** `plot_bar_percent_second_div.m`  
- **Description:** Bar graph showing percentage of cells undergoing a second division.  

**4E & 4F: Cell arrest in G1**  
- **Script:** `steptmp_cycif_thymidine_plot_bar_untreated.m`  
- **Description:** Bar graphs comparing asynchronous cell-cycle distributions without and with TMP.  

**4G: Tracking – Serum Starvation**  
- **Script:** `plot_tracking_g1_constant_tmp.m`  
- **Description:** Time series of N/C ratio for single cells under serum starvation ± TMP.  

**4H: Tracking – Double Thymidine**  
- **Script:** `plot_tracking_s_constant_tmp.m`  
- **Description:** Time series of N/C ratio for single cells under double thymidine ± TMP.  

**4I: Initial activation rate – Serum Starvation**  
- **Script:** `plot_peak_amplitude_g1_constant_tmp.m`  
- **Description:** Box plot comparing fitted Vₘₐₓ (peak amplitude) and peak time under serum starvation.  

**4J: Tracking – Pulse TMP treatment**  
- **Script:** `plot_tracking_s_pulse_tmp.m`  
- **Description:** Time series of N/C ratio for single-cell tracks in an add–remove–add TMP paradigm.  

---

> **Note:** Only the `.m` scripts used to generate each panel’s quantitative analysis are listed here. Graphics or image-only panels are not included.
