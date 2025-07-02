# FPGA Stepper Motor Controller

A Verilog-based controller for unipolar/bipolar stepper motors, implemented on the Intel DE1-SoC (Cyclone V FPGA). Supports full-step and half-step modes, bidirectional motion, acceleration/deceleration, and real-time speed display. Developed with Quartus and ModelSim as part of a digital systems lab.

---

## 🔧 Features

- **Supports:** Unipolar/Bipolar 4-phase stepper motors
- **Modes:** Full-step and Half-step (selectable via `SW3`)
- **Direction:** Clockwise / Counter-clockwise (`SW1`)
- **Motion:** Continuous rotation or quarter-turn bursts (`SW2` + `KEY1`)
- **Speed Control:** 10–60 RPM (33–200 steps/sec), adjustable with `KEY3`
- **Acceleration:** Smooth ladder acceleration/deceleration
- **Interface:** Speed displayed in real-time on 7-segment display
- **Clock:** 50 MHz system clock

---

## 📁 Directory Structure

fpga-stepper-controller/
├── rtl/ # Verilog HDL source files
├── sim/ # ModelSim testbenches and waveforms
├── synth/ # Quartus project files, resource & timing reports
├── docs/ # Architecture diagrams, pinouts, images
└── README.md

---

## 🚀 Getting Started

### Requirements

- Intel Quartus Prime (tested on 20.1+)
- ModelSim (Intel Edition)
- Intel DE1-SoC (Cyclone V FPGA)
- 4-phase stepper motor (e.g., 28BYJ-48)

### Steps

1. Clone the repository
2. Open the Quartus project in synth/ and compile.
3. Program the FPGA.
4. Connect the stepper motor.
5. Use board switches and keys:
  SW1: Direction (CW/CCW)
  SW2: Motion mode (continuous or burst)
  SW3: Step mode (full/half)
  KEY1: Trigger quarter-turn
  KEY3: Cycle through speeds

---

## 📐 Design Overview

- Pulse Generator FSM: Handles precise step timing per speed setting
- Step Control Logic: Decodes direction, mode, step type, and triggers pulses
- Speed Controller: Manages acceleration/deceleration state transitions
- Debouncers: For reliable switch and key input
- Display Driver: Real-time speed output on 7-segment display

---

## 🧪 Simulation
- All modules validated with ModelSim testbenches
- Test cases: direction change, step mode switching, acceleration ramping, burst mode, and speed transitions
- Example waveforms in sim/waveforms/

---

## 🎥 Demo
- https://drive.google.com/file/d/1mPK3cCsCBrTO6Z6PHUh9RFMxDq8YPn4j/view?usp=drivesdk
