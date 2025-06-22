# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock, Timer
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await Timer(15, units='ns')
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    dut.ui_in.value = 0
    await Timer(10, units='ns')
    assert dut.uo_out.value == 0

    dut.ui_in.value = 1
    await Timer(10, units='ns')
    assert dut.uo_out.value == 1

    dut.ui_in.value = 0
    await Timer(10, units='ns')
    assert dut.uo_out.value == 2

    dut.ui_in.value = 0
    await Timer(10, units='ns')
    assert dut.uo_out.value == 3

    dut.ui_in.value = 0
    await Timer(10, units='ns')
    assert dut.uo_out.value == 4

    dut.ui_in.value = 0
    await Timer(10, units='ns')
    assert dut.uo_out.value == 0
