# Telecommunication Systems Project

## Overview
This project explores **high-order constellations** in digital communication systems, focusing on achieving high-speed data transmission and energy efficiency. Using the **Hexagonal Quadrature Amplitude Modulation (HQAM)** scheme, the project aims to address challenges in detection algorithms for next-generation telecommunication systems (6G and beyond).

---

## Goals
- **High-Order Constellations**: Investigate HQAM constellations to enhance data rate and energy efficiency.
- **Algorithm Development**: Propose a novel symbol detection algorithm utilizing dynamic circle radii.
- **Performance Analysis**: Simulate the Symbol Error Probability (SEP) of HQAM constellations and compare with existing methods.

---

## Features
### Simulation and Analysis
- **HQAM Symbol Error Probability (SEP)**: 
  - Simulated SEP for constellations of size M = [16, 32, 64, 128, 256, 512, 1024].
  - Comparison with existing methods to validate accuracy.
- **Upper Bound Approximation**:
  - Visualization of the upper bounds for SEP under different configurations.

### Proposed Detection Algorithm
- **Dynamic Circle Detection**:
  - Utilizes circles of varying radii centered on received symbols for efficient detection.
  - Reduces the computational complexity compared to Maximum Likelihood Detection (MLD).
- **Database of Optimal Radii**:
  - Precomputed for specific system parameters (e.g., SNR, dmin) to enhance detection efficiency.

---

## Results
- **Accurate Simulations**:
  - The proposed method closely aligns with simulated SEP, confirming reliability.
- **Improved Detection Efficiency**:
  - The novel algorithm performs comparably to MLD while reducing computational costs.
- **Energy Efficiency**:
  - HQAM demonstrated superior energy efficiency due to the dense packing of symbols in the constellation.

---

## Repository Contents
- **Report**: Detailed analysis and findings in [Project Report](./Project%20Report.pdf).
- **Code**: MATLAB scripts for simulation and analysis of HQAM constellations.

---

## 🤝 Contributors
- Panagiotis Karvounaris
- Pigi Papanikolaou

## 📬 Contact
For questions or collaboration, feel free to reach out via GitHub.

---

Thank you for checking out this project! 😊
