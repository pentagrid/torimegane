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
     MAVSDK::mavsdk
    Qt5::Core Qt5::Gui Qt5::WebEngineCore Qt5::Widgets Qt5::WebEngine
)

if(NOT MSVC)
    add_compile_options(torimegane PRIVATE -Wall -Wextra -I/usr/include/mavsdk )
else()
    add_compile_options(torimegane PRIVATE -WX -W2 -I/usr/include/mavsdk )
endif()

