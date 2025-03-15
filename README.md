# Overview
This repository contains a Verilog implementation of a Fast Fourier Transform (FFT) processor. The design includes modules for butterfly operations, address generation, memory (RAM/ROM), and various support components to facilitate N-point FFT computations. The primary goal is to demonstrate a hardware-friendly FFT approach that can be synthesized on an FPGA or ASIC.

# Key Modules
## FFT.v
Top-level module for the FFT processor. Instantiates submodules such as butterfly units, address generators, memory blocks, and multiplexers.

## BFU.v (Butterfly Unit)
Implements the radix-2 butterfly operation. Accepts two complex inputs and outputs the summed and subtracted values for each FFT stage.

## AGU.v (Address Generation Unit)
Generates read/write addresses for accessing data in RAM or ROM during each FFT stage, handling bit-reversal or in-order addressing as needed.

## MEM.v, RAM.v, ROM.v

**MEM.v:** Manages overall memory interface.
**RAM.v:** Stores intermediate FFT data between stages.
**ROM.v:** Contains twiddle factors (precomputed complex exponentials).
**cx_adder.v, cx_subtractor.v, cx_multiplier.v**
Arithmetic blocks for performing addition, subtraction, and multiplication of complex numbers.

## main.v
May serve as a test harness or secondary top-level that ties everything together for simulation or FPGA deployment.

# Supporting Modules

**clk_delay.v, counter_3bm5.v, counter_4b.v:** Utility modules for timing, clock edge detection, or counting operations.
**mux_2ch.v, mux_4ch.v:** Multiplexers for routing signals.
**right_shift.v, rotate_left_5b.v:** Bit-shift operations for scaling or rotating data.
**Flip-Flops (dff.v, srff.v, tff.v):** Basic sequential elements used throughout the design.
# Features
- Radix-2 FFT with butterfly units and efficient memory access.
- Complex Arithmetic supporting real and imaginary parts in fixed-point format.
- Modular Architecture enabling easy extension or customization for different word sizes or FFT lengths.
