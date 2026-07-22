######################################################################
#
# DESCRIPTION: Verilator CMake Example: Small CMakeLists.txt
#
# This is an example cmake script to build a verilog to systemc project
# using cmake and verilator.
#
# This file ONLY is placed under the Creative Commons Public Domain
# SPDX-FileCopyrightText: 2020 Wilson Snyder
# SPDX-License-Identifier: CC0-1.0
#
######################################################################

# This example builds the tracing_c example using CMake
# To use it, run the following:

# cd /path/to/verilator/examples/cmake_psc
# rm -rf build && mkdir build && cd build
# cmake ..
# cmake --build .

cmake_minimum_required(VERSION 3.12)
cmake_policy(SET CMP0074 NEW)
project(cmake_psc)

find_package(verilator HINTS $ENV{VERILATOR_ROOT} ${VERILATOR_ROOT})
if(NOT verilator_FOUND)
    message(
        FATAL_ERROR
        "Verilator was not found. Either install it, or set the VERILATOR_ROOT environment variable"
    )
endif()

# Create a new executable target that will contain all your sources
add_executable(example ../make_psc/sim_main.cpp)
target_compile_features(example PUBLIC cxx_std_14)
add_custom_command(
    OUTPUT ${CMAKE_CURRENT_SOURCE_DIR}/../instructions.txt
    COMMAND python3 ${CMAKE_CURRENT_SOURCE_DIR}/../assembler.py
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/../make_psc
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/../codes.txt
    COMMENT "codes.txt changed, running assembler.py to generate instructions.txt"
)
add_custom_target(run_assembler
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/../instructions.txt
)
file(COPY "../instructions.txt" DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

# Add the Verilated circuit to the target
verilate(example TRACE_VCD
  INCLUDE_DIRS "../make_psc"
  SOURCES ../make_psc/top.sv
  VERILATOR_ARGS --timing
)
add_dependencies(example run_assembler)

add_custom_target(run
    COMMAND example
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/../make_psc
    DEPENDS example
)