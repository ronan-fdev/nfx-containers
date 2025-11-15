#==============================================================================
# nfx-containers - Library installation
#==============================================================================

#----------------------------------------------
# Installation condition check
#----------------------------------------------

if(NOT NFX_CONTAINERS_INSTALL_PROJECT)
	message(STATUS "Installation disabled, skipping...")
	return()
endif()

#----------------------------------------------
# Installation paths configuration
#----------------------------------------------

include(GNUInstallDirs)

message(STATUS "System installation paths:")
message(STATUS "  Headers      : ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}")
message(STATUS "  Library      : ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
message(STATUS "  Binaries     : ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_BINDIR}")
message(STATUS "  CMake configs: ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/cmake/nfx-containers")
message(STATUS "  Documentation: ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_DOCDIR}")

#----------------------------------------------
# Install headers
#----------------------------------------------

install(
	DIRECTORY "${NFX_CONTAINERS_INCLUDE_DIR}/"
	DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
	COMPONENT Development
	FILES_MATCHING PATTERN "*.h" PATTERN "*.hpp" PATTERN "*.inl"
)

#----------------------------------------------
# Install library targets
#----------------------------------------------

set(INSTALL_TARGETS)

# Header-only interface library
list(APPEND INSTALL_TARGETS ${PROJECT_NAME})

# Install nfx-hashing dependency if built via FetchContent
if(NOT nfx-hashing_FOUND AND TARGET nfx-hashing::nfx-hashing)
	# Add nfx-hashing to export set
	list(APPEND INSTALL_TARGETS nfx-hashing)
	
	# Install nfx-hashing headers
	get_target_property(NFX_HASHING_SOURCE_DIR nfx-hashing::nfx-hashing SOURCE_DIR)
	if(NFX_HASHING_SOURCE_DIR)
		install(
			DIRECTORY "${NFX_HASHING_SOURCE_DIR}/include/"
			DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
			COMPONENT Development
			FILES_MATCHING
				PATTERN "*.h"
				PATTERN "*.hpp"
				PATTERN "*.inl"
		)
		
		# Install nfx-hashing LICENSE file
		if(EXISTS "${NFX_HASHING_SOURCE_DIR}/LICENSE.txt")
			install(
				FILES "${NFX_HASHING_SOURCE_DIR}/LICENSE.txt"
				DESTINATION "${CMAKE_INSTALL_DOCDIR}/licenses"
				RENAME LICENSE-nfx-hashing.txt
				COMPONENT Development
			)
		endif()
		
		# Install nfx-hashing CMake config files
		install(
			EXPORT nfx-hashing-targets
			FILE nfx-hashing-targets.cmake
			NAMESPACE nfx-hashing::
			DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/nfx-hashing
			COMPONENT Development
		)
		
		# Configure and install nfx-hashing package config
		include(CMakePackageConfigHelpers)
		configure_package_config_file(
			"${NFX_HASHING_SOURCE_DIR}/cmake/nfx-hashing-config.cmake.in"
			"${CMAKE_CURRENT_BINARY_DIR}/nfx-hashing-config.cmake"
			INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/nfx-hashing
		)
		
		write_basic_package_version_file(
			"${CMAKE_CURRENT_BINARY_DIR}/nfx-hashing-config-version.cmake"
			VERSION 0.1.1
			COMPATIBILITY SameMajorVersion
		)
		
		install(
			FILES
				"${CMAKE_CURRENT_BINARY_DIR}/nfx-hashing-config.cmake"
				"${CMAKE_CURRENT_BINARY_DIR}/nfx-hashing-config-version.cmake"
			DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/nfx-hashing
			COMPONENT Development
		)
	endif()
endif()

if(INSTALL_TARGETS)
	# Separate nfx-hashing from nfx-containers targets
	list(REMOVE_ITEM INSTALL_TARGETS nfx-hashing)
	set(NFX_HASHING_TARGET "")
	if(NOT nfx-hashing_FOUND AND TARGET nfx-hashing::nfx-hashing)
		set(NFX_HASHING_TARGET nfx-hashing)
	endif()
	
	# Install nfx-hashing target separately if needed
	if(NFX_HASHING_TARGET)
		install(
			TARGETS ${NFX_HASHING_TARGET}
			EXPORT nfx-hashing-targets
			ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
				COMPONENT Development
			LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
				COMPONENT Runtime
			RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
				COMPONENT Runtime
			INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
		)
	endif()
	
	# Install nfx-containers targets
	install(
		TARGETS ${INSTALL_TARGETS}
		EXPORT nfx-containers-targets
		ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
			COMPONENT Development
		LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
			COMPONENT Runtime
		RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
			COMPONENT Runtime
		INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
	)
endif()

#----------------------------------------------
# Install CMake config files
#----------------------------------------------

install(
	EXPORT nfx-containers-targets
	FILE nfx-containers-targets.cmake
	NAMESPACE nfx-containers::
	DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/nfx-containers
	COMPONENT Development
)

# Install separate target files for each configuration (multi-config generators)
if(CMAKE_CONFIGURATION_TYPES)
	foreach(CONFIG ${CMAKE_CONFIGURATION_TYPES})
		install(
			EXPORT nfx-containers-targets
			FILE nfx-containers-targets-${CONFIG}.cmake
			NAMESPACE nfx-containers::
			DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/nfx-containers
			CONFIGURATIONS ${CONFIG}
			COMPONENT Development
		)
	endforeach()
endif()

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
	"${CMAKE_CURRENT_BINARY_DIR}/nfx-containers-config-version.cmake"
	VERSION ${PROJECT_VERSION}
	COMPATIBILITY SameMajorVersion
)

configure_package_config_file(
	"${CMAKE_CURRENT_SOURCE_DIR}/cmake/nfx-containers-config.cmake.in"
	"${CMAKE_CURRENT_BINARY_DIR}/nfx-containers-config.cmake"
	INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/nfx-containers
)

install(
	FILES
		"${CMAKE_CURRENT_BINARY_DIR}/nfx-containers-config.cmake"
		"${CMAKE_CURRENT_BINARY_DIR}/nfx-containers-config-version.cmake"
	DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/nfx-containers
	COMPONENT Development
)

#----------------------------------------------
# Install license files
#----------------------------------------------

install(
	FILES "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE.txt"
	DESTINATION "${CMAKE_INSTALL_DOCDIR}/licenses"
)

install(
	DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/licenses/"
	DESTINATION "${CMAKE_INSTALL_DOCDIR}/licenses"
	FILES_MATCHING PATTERN "LICENSE.txt-*"
)

#----------------------------------------------
# Install documentation
#----------------------------------------------

if(NFX_CONTAINERS_BUILD_DOCUMENTATION)
	install(
		DIRECTORY "${CMAKE_BINARY_DIR}/doc/html"
		DESTINATION ${CMAKE_INSTALL_DOCDIR}
		OPTIONAL
		COMPONENT Documentation
	)
	
	if(WIN32)
		# Install Windows .cmd batch file
		install(
			FILES "${CMAKE_BINARY_DIR}/doc/index.html.cmd"
			DESTINATION ${CMAKE_INSTALL_DOCDIR}
			OPTIONAL
			COMPONENT Documentation
		)
	else()
		# Install Unix symlink
		install(
			FILES "${CMAKE_BINARY_DIR}/doc/index.html"
			DESTINATION ${CMAKE_INSTALL_DOCDIR}
			OPTIONAL
			COMPONENT Documentation
		)
	endif()
endif()

message(STATUS "Installation configured for targets: ${INSTALL_TARGETS}")
