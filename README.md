# Novera Tools

Development tools for the Novera game project. This repository contains utility applications and archive libraries built with Visual Studio 2010 (v100 toolset) and managed via Premake5.

## Projects

| Project | Type | Description |
|---------|------|-------------|
| ZipArchive | Static Lib | Zip archive library (MFC dynamic) |
| ZipArc | App | Zip archive test application (MFC dynamic) |
| LSLog | Static Lib | Logging library (static runtime) |
| ioPac | Static Lib | Pack file system library (static, patch variant) |
| PatchManager | App | Patch management tool (MFC static, /MT) |
| LSMonitor | App | Server monitoring tool (MFC dynamic) |

## Prerequisites

- Visual Studio 2010 (or VS 2022 with v100 platform toolset)
- Windows SDK 7.0A
- Premake5 is auto-downloaded by `build.bat` (no manual install needed)

## Building

### Quick start

```batch
build.bat                    # Generate VS2010 project files (auto-downloads premake5)
scripts\build.bat Debug       # Build solution (Debug)
scripts\build.bat All         # Build Debug + Release
```

### Build single project

```batch
scripts\build_project.bat PatchManager              # Debug (default)
scripts\build_project.bat LSMonitor Release          # Release config
scripts\build_project.bat                            # List available projects
```

## Directory Structure

```
SourceTool/
├── premake5.lua          # Premake5 build configuration
├── scripts/              # Build helper scripts (gen_version.bat)
├── src/                  # Source code
│   ├── ziparchive320/    # ZipArchive library + ZipArc test app
│   ├── ioPac/            # Pack file system (static, patch variant)
│   │   └── ZipArchive/   # Pre-built ZipArchive headers
│   ├── LSLog/            # Logging library
│   ├── PatchManager/     # Patch management tool
│   └── LSMonitor/        # Server monitoring tool
├── lib/                  # Build outputs (.lib) + pre-built dependencies
│   └── ZipArchive/       # Pre-built ZipArchive static libs
└── build/                # Generated VS2010 project files (gitignored)
```

## License

This project is licensed under the GNU General Public License v3.0 — see [LICENSE](LICENSE) for details.

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) before submitting pull requests.
