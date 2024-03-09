# Copyright 2024 Manfred Trauner
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE−2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


#@cocotb.test()
#async def test_adder(dut):
#  dut._log.info("Start")
  
  # Our example module doesn't use clock and reset, but we show how to use them here anyway.
#  clock = Clock(dut.clk, 10, units="us")
#  cocotb.start_soon(clock.start())

  # Reset
#  dut._log.info("Reset")
#  dut.ena.value = 1
#  dut.ui_in.value = 0
#  dut.uio_in.value = 0
#  dut.rst_n.value = 0
#  await ClockCycles(dut.clk, 10)
#  dut.rst_n.value = 1

  # Set the input values, wait one clock cycle, and check the output
#  dut._log.info("Test")
#  dut.ui_in.value = 20
#  dut.uio_in.value = 30

#  await ClockCycles(dut.clk, 1)

#  assert dut.uo_out.value == 50
