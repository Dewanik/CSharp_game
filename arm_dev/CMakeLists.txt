cmake_minimum_required(VERSION 3.10)
project(NintendoArmHelloWorld C)

# Set ARM architecture flags
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -march=armv8-a -mtune=cortex-a57 -mtp=soft -fPIE")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -Wall -O2 -ffunction-sections")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D__SWITCH__")

# Source files
set(SOURCES
    src/main.c
)

# Create executable
add_executable(hello_world ${SOURCES})

# Link libnx
if(DEFINED DEVKITARM)
    target_link_directories(hello_world PRIVATE ${DEVKITARM}/../libnx/lib)
    target_include_directories(hello_world PRIVATE ${DEVKITARM}/../libnx/include)
    target_link_libraries(hello_world PRIVATE nx)
else()
    message(WARNING "DEVKITARM not set. Set it with: export DEVKITARM=<path>")
endif()

# Print build info
message(STATUS "Building for Nintendo Switch ARM")
message(STATUS "Target: hello_world")
