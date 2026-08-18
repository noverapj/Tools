-- Tool workspace (PatchManager, ZipArchive, ZipArc, LSMonitor)
-- MFC: use mfc "Dynamic"/"Static" API

workspace "Tool"
    configurations { "Debug", "Release" }
    platforms { "Win32" }
    toolset "v100"
    location "build"

    targetdir "../build/zone_novera/tools/%{cfg.buildcfg}/%{prj.name}"
    objdir "build/%{prj.name}/%{cfg.buildcfg}"

    filter "kind:StaticLib"
        targetdir "lib"
    filter {}

    -- global compile settings
    multiprocessorcompile "On"
    characterset "MBCS"
    warnings "Extra"
    exceptionhandling "On"
    rtti "On"
    symbols "On"
    editandcontinue "On"

    filter "configurations:Debug"
        runtime "Debug"
        defines "_DEBUG"
        optimize "Off"
    filter "configurations:Release"
        runtime "Release"
        defines "NDEBUG"
        optimize "Speed"
    filter {}

group "Archive"

-- ZipArchive (static library, MFC dynamic)
project "ZipArchive"
    kind "StaticLib"
    language "C++"
    location "build"
    mfc "Dynamic"
    defines { "ZIP_ARCHIVE_MFC", "NO_DUMMY_DECL" }
    files {
        "src/ziparchive320/ZipArchive/**.cpp",
        "src/ziparchive320/ZipArchive/**.h",
        "src/ziparchive320/ZipArchive/**.c",
        "src/ziparchive320/ZipArchive/**.rc",
    }
    removefiles { "src/ziparchive320/ZipArchive/ZipArchive.rc" }
    vpaths {
        ["Source Files"] = { "src/ziparchive320/ZipArchive/**.cpp", "src/ziparchive320/ZipArchive/**.c" },
        ["Header Files"] = { "src/ziparchive320/ZipArchive/**.h" },
    }
    filter "configurations:Debug"
        targetsuffix "d"
    filter {}

-- ZipArc (test app, MFC, links ZipArchive)
project "ZipArc"
    kind "WindowedApp"
    language "C++"
    location "build"
    mfc "Dynamic"
    defines { "ZIP_ARCHIVE_MFC", "_WINDOWS" }
    includedirs { "src/ziparchive320/ZipArchive", "src/ziparchive320/ZipArc" }
    libdirs { "lib" }
    links { "ZipArchive" }
    pchheader "StdAfx.h"
    pchsource "src/ziparchive320/ZipArc/StdAfx.cpp"
    files {
        "src/ziparchive320/ZipArc/**.cpp",
        "src/ziparchive320/ZipArc/**.h",
        "src/ziparchive320/ZipArc/**.rc",
    }
    removefiles { "src/ziparchive320/ZipArc/_UpgradeReport_Files/**" }
    vpaths {
        ["Source Files"] = { "src/ziparchive320/ZipArc/**.cpp" },
        ["Header Files"] = { "src/ziparchive320/ZipArc/**.h" },
        ["Resource Files"] = { "src/ziparchive320/ZipArc/**.rc" },
    }

group "Libs"

-- LSLog (static lib)
project "LSLog"
    kind "StaticLib"
    language "C++"
    location "build"
    staticruntime "On"
    defines { "LSLOG_STATIC" }
    files { "src/LSLog/**.h", "src/LSLog/**.cpp" }
    vpaths {
        ["Source Files"] = { "src/LSLog/**.cpp" },
        ["Header Files"] = { "src/LSLog/**.h" },
    }
    filter "configurations:Debug" runtime "Debug"; targetname "LSLogStaticd"
    filter "configurations:Release" runtime "Release"; targetname "LSLogStatic"
    filter {}

-- ioPac (static lib, patch variant)
project "ioPac"
    kind "StaticLib"
    language "C++"
    location "build"
    staticruntime "On"
    defines { "STATIC_PAC_API", "PATCH_PAC_API" }
    files { "src/ioPac/**.h", "src/ioPac/**.cpp" }
    removefiles { "src/ioPac/main.cpp", "src/ioPac/Script1.rc" }
    libdirs { "lib", "lib/ZipArchive" }
    vpaths {
        ["Source Files"] = { "src/ioPac/**.cpp" },
        ["Header Files"] = { "src/ioPac/**.h" },
        ["Resource Files"] = { "src/ioPac/**.rc" },
    }
    filter "configurations:Debug" runtime "Debug"; targetname "ioPacStaticPatchd"
    filter "configurations:Release" runtime "Release"; targetname "ioPacStaticPatch"
    filter {}

group "Tools"

-- PatchManager (MFC static app)
project "PatchManager"
    kind "WindowedApp"
    language "C++"
    location "build"
    mfc "Static"
    defines { "_WINDOWS" }
    staticruntime "On"
    includedirs { "src/PatchManager", "src" }
    libdirs { "lib" }
    links { "ws2_32", "version", "LSLog", "ioPac" }
    files {
        "src/PatchManager/**.cpp",
        "src/PatchManager/**.h",
        "src/PatchManager/**.c",
        "src/PatchManager/**.rc",
    }
    removefiles { "src/PatchManager/ZipArchive/**" }
    vpaths {
        ["Source Files"] = { "src/PatchManager/**.cpp", "src/PatchManager/**.c" },
        ["Header Files"] = { "src/PatchManager/**.h" },
        ["Resource Files"] = { "src/PatchManager/**.rc" },
    }
    prebuildcommands { '"$(ProjectDir)..\\scripts\\gen_version.bat" "$(ProjectDir)..\\src\\PatchManager" Version.h' }

-- LSMonitor (MFC dynamic app)
project "LSMonitor"
    kind "WindowedApp"
    language "C++"
    location "build"
    mfc "Dynamic"
    defines { "_WINDOWS" }
    includedirs { "src/LSMonitor", "src" }
    libdirs { "lib" }
    pchheader "stdafx.h"
    pchsource "src/LSMonitor/stdafx.cpp"
    files {
        "src/LSMonitor/**.cpp",
        "src/LSMonitor/**.h",
        "src/LSMonitor/**.rc",
    }
    vpaths {
        ["Source Files"] = { "src/LSMonitor/**.cpp" },
        ["Header Files"] = { "src/LSMonitor/**.h" },
        ["Resource Files"] = { "src/LSMonitor/**.rc" },
    }
    prebuildcommands { '"$(ProjectDir)..\\scripts\\gen_version.bat" "$(ProjectDir)..\\src\\LSMonitor" Version.h' }
