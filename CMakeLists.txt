cmake_minimum_required(VERSION 3.10.2)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

project(torimegane)

add_executable(torimegane
    bd_telemetry.cpp
    bd_backend.cpp
    bd_backend.hpp
    bd_telemetry.hpp
    main.cpp
)

set_target_properties(${PROJECT_NAME} PROPERTIES AUTOMOC TRUE)

find_package(MAVSDK REQUIRED)

find_package(Qt5 5.12.8 REQUIRED COMPONENTS Core Gui  WebEngine Widgets)


target_link_libraries(torimegane
     MAVSDK::mavsdk MAVSDK::mavsdk_action MAVSDK::mavsdk_calibration MAVSDK::mavsdk_camera MAVSDK::mavsdk_follow_me MAVSDK::mavsdk_geofence MAVSDK::mavsdk_gimbal MAVSDK::mavsdk_info MAVSDK::mavsdk_log_files MAVSDK::mavsdk_ftp MAVSDK::mavsdk_mission MAVSDK::mavsdk_mission_raw MAVSDK::mavsdk_mocap MAVSDK::mavsdk_offboard MAVSDK::mavsdk_param MAVSDK::mavsdk_shell MAVSDK::mavsdk_telemetry MAVSDK::mavsdk_tune
     MAVSDK::mavsdk_mavlink_passthrough
    Qt5::Core Qt5::Gui Qt5::WebEngineCore Qt5::Widgets Qt5::WebEngine
)

if(NOT MSVC)
    add_compile_options(torimegane PRIVATE -Wall -Wextra -I/usr/include/mavsdk )
else()
    add_compile_options(torimegane PRIVATE -WX -W2 -I/usr/include/mavsdk )
endif()

