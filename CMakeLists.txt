cmake_minimum_required(VERSION 3.14)

project(tensorflow-playground)

# set(CMAKE_CXX_STANDARD 11)
# set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library(tensorflow STATIC IMPORTED)

set_property(
  TARGET tensorflow APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG
)

set_target_properties(tensorflow PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${tensorflow_ROOT}/lib/tensorflow.lib"
)

set_property(
  TARGET tensorflow APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE
)

set_target_properties(tensorflow PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${tensorflow_ROOT}/lib/tensorflow.lib"
)
  
set_target_properties(tensorflow PROPERTIES
  MAP_IMPORTED_CONFIG_MINSIZEREL Release
  MAP_IMPORTED_CONFIG_RELWITHDEBINFO Release
)

target_include_directories(tensorflow INTERFACE "${tensorflow_ROOT}/include")

add_executable(${PROJECT_NAME} 
    "src/main.cpp"
)

target_link_libraries(${PROJECT_NAME} tensorflow)
add_custom_command(
	TARGET ${PROJECT_NAME} POST_BUILD
	COMMAND ${CMAKE_COMMAND} -E copy_if_different "${tensorflow_ROOT}/lib/tensorflow.dll" $<TARGET_FILE_DIR:${PROJECT_NAME}>
)