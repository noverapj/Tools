# Novera Tools

Development tools for the Novera game project. This repository contains utility applications and archive libraries built with Visual Studio 2010 (v100 toolset) and managed via Premake5.

## Projects

| Project | Type | Description |
|---------|------|-------------|
| ZipArchive | Static Lib | Zip archive library (MFC dynamic) |
| ZipArc | App | Zip archive test application (MFC dynamic) |
| PatchManager | App | Patch management tool (MFC static, /MT) |
| LSMonitor | App | Server monitoring tool (MFC dynamic) |

## Prerequisites

- Visual Studio 2010 (or VS 2022 with v100 platform toolset)
- Premake5 (beta 8)
- Windows SDK 7.0A
- SourceClient repository (PatchManager and LSMonitor depend on ioPac, LSLog, TownPortal from SourceClient)

## Building

```batch
premake5.exe vs2010 --file=premake5.lua
msbuild build\Tool.sln /p:Configuration=Debug /p:Platform=Win32 /p:PlatformToolset=v100 /m
```

## Directory Structure

```
SourceTool/
├── premake5.lua          # Premake5 build configuration
├── scripts/              # Build helper scripts
├── src/                  # Source code
│   ├── ziparchive320/    # ZipArchive library + ZipArc test app
│   ├── PatchManager/     # Patch management tool
│   └── LSMonitor/        # Server monitoring tool
├── lib/                  # Build outputs (.lib) + pre-built dependencies
└── build/                # Generated VS2010 project files (gitignored)
```

## Dependencies

PatchManager and LSMonitor reference headers and static libraries from the SourceClient repository:

- `../SourceClient/src/` — Shared source headers (ioPac, LSLog, TownPortal)
- `../SourceClient/lib/` — Pre-built static libraries (ioPacStatic, LSLogStatic, TownPortalStatic)

## License

This project is licensed under the GNU General Public License v3.0 — see [LICENSE](LICENSE) for details.

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) before submitting pull requests.
