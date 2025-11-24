# Go Development Setup

This directory contains configuration files and setup scripts for Go development.

## Contents

- `install.sh` - Automated installation script for Go tools and libraries
- `golangcli.yml.example` - Example configuration file for Go CLI applications
- `REQUIREMENTS.md` - Manual installation guide for all required tools

## Quick Start

### Installation

Run the installation script to set up your Go development environment:

```bash
./install.sh
```

The script will:
- Skip Go installation if already present (or install latest version if not found)
- Configure Go environment variables in `.zshrc`
- Install LSP servers and development tools
- Install common Go libraries and frameworks

After installation, restart your shell or run:
```bash
source ~/.zshrc
```

## What Gets Installed

### Development Tools

- **gopls** - Official Go Language Server for LSP support
- **golangci-lint** - Fast linters runner for code quality
- **delve (dlv)** - Go debugger
- **goimports** - Automatic import formatting
- **staticcheck** - Advanced static analysis
- **gomodifytags** - Modify struct field tags
- **impl** - Generate interface implementations
- **gotests** - Automatically generate tests
- **air** - Live reload for Go applications
- **cobra-cli** - CLI application scaffolding

### Common Libraries

#### CLI Frameworks
- cobra - Popular CLI framework
- viper - Configuration management

#### Web Frameworks
- gin - Fast HTTP web framework
- echo - High performance web framework

#### Database
- PostgreSQL driver (lib/pq)
- MySQL driver (go-sql-driver/mysql)
- GORM ORM with Postgres and MySQL drivers

#### Utilities
- logrus - Structured logging
- testify - Testing toolkit
- validator - Struct and field validation

## Environment Variables

The installation script configures:

```bash
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
```

## Directory Structure

After installation, your Go workspace will be:

```
$HOME/go/
├── bin/        # Compiled binaries and tools
├── pkg/        # Package objects
└── src/        # Source code
```

## Using golangcli.yml

Copy the example configuration:

```bash
cp golangcli.yml.example golangcli.yml
```

Customize it for your CLI application with:
- Application metadata (name, version, description)
- Build configuration (output directory, binary name, platforms)
- CLI commands and flags
- Logging, database, and API settings

## Creating a New CLI Application

Using cobra-cli:

```bash
# Initialize a new CLI app
cobra-cli init myapp

# Add a new command
cd myapp
cobra-cli add serve
```

## Manual Installation

For manual installation instructions, see `REQUIREMENTS.md`.

## Troubleshooting

### Command not found after installation

Ensure Go binaries are in your PATH:
```bash
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
source ~/.zshrc
```

Restart Neovim after updating PATH.

### Permission errors during installation

The script will automatically use sudo when needed. If you encounter permission issues:
```bash
# Run with sudo if needed
sudo ./install.sh
```

### Updating tools

To update all Go tools to their latest versions, simply re-run the installation script:
```bash
./install.sh
```

## Resources

- [Go Official Documentation](https://go.dev/doc/)
- [Go by Example](https://gobyexample.com/)
- [Effective Go](https://go.dev/doc/effective_go)
- [Cobra Documentation](https://cobra.dev/)
- [GORM Documentation](https://gorm.io/)
