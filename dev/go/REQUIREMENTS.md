# Go Development Environment Requirements

This document lists all required tools and dependencies for a complete Go development environment on Arch Linux.

## System Requirements

### Base System Packages

Install these packages using pacman:

```bash
sudo pacman -S base-devel git wget curl
```

- **base-devel** - Essential development tools (gcc, make, etc.)
- **git** - Version control system
- **wget** - File downloader (for Go binary)
- **curl** - HTTP client (for fetching latest version info)

## Go Installation

### Option 1: Manual Installation (Recommended)

1. **Download Go**
   - Visit: https://go.dev/dl/
   - Download latest `linux-amd64.tar.gz` file
   - Or use wget:
     ```bash
     wget https://go.dev/dl/go1.23.4.linux-amd64.tar.gz
     ```

2. **Extract and Install**
   ```bash
   sudo rm -rf /usr/local/go
   sudo tar -C /usr/local -xzf go*.linux-amd64.tar.gz
   ```

3. **Configure Environment**

   Add to `~/.zshrc`:
   ```bash
   export GOPATH=$HOME/go
   export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
   ```

4. **Create Go Workspace**
   ```bash
   mkdir -p $HOME/go/{bin,src,pkg}
   ```

5. **Apply Changes**
   ```bash
   source ~/.zshrc
   ```

6. **Verify Installation**
   ```bash
   go version
   go env
   ```

### Option 2: Package Manager Installation

```bash
sudo pacman -S go
```

Note: May not be the latest version. Manual installation recommended for latest features.

## LSP and Development Tools

Once Go is installed, install these tools using `go install`:

### Language Server

```bash
# gopls - Official Go Language Server
go install golang.org/x/tools/gopls@latest
```

### Linting and Analysis

```bash
# golangci-lint - Fast linters runner
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b "$HOME/go/bin" latest

# staticcheck - Advanced static analysis
go install honnef.co/go/tools/cmd/staticcheck@latest
```

### Debugging

```bash
# delve - Go debugger
go install github.com/go-delve/delve/cmd/dlv@latest
```

### Code Formatting

```bash
# goimports - Auto format imports
go install golang.org/x/tools/cmd/goimports@latest
```

### Code Generation

```bash
# gomodifytags - Modify struct tags
go install github.com/fatih/gomodifytags@latest

# impl - Generate interface implementations
go install github.com/josharian/impl@latest

# gotests - Generate tests
go install github.com/cweill/gotests/gotests@latest
```

### Development Utilities

```bash
# air - Live reload for Go apps
go install github.com/air-verse/air@latest

# cobra-cli - CLI application scaffolding
go install github.com/spf13/cobra-cli@latest
```

## Common Go Libraries

These don't need to be "installed" globally but are commonly used in projects. They'll be downloaded when you run `go get` or `go mod download` in your projects.

### CLI Frameworks

```bash
# In your project directory
go get -u github.com/spf13/cobra@latest
go get -u github.com/spf13/viper@latest
```

### Web Frameworks

```bash
# Gin - Fast HTTP web framework
go get -u github.com/gin-gonic/gin@latest

# Echo - High performance web framework
go get -u github.com/labstack/echo/v4@latest
```

### Database

```bash
# PostgreSQL driver
go get -u github.com/lib/pq@latest

# MySQL driver
go get -u github.com/go-sql-driver/mysql@latest

# GORM ORM
go get -u gorm.io/gorm@latest
go get -u gorm.io/driver/postgres@latest
go get -u gorm.io/driver/mysql@latest
```

### Utilities

```bash
# Logrus - Structured logging
go get -u github.com/sirupsen/logrus@latest

# Testify - Testing toolkit
go get -u github.com/stretchr/testify@latest

# Validator - Struct validation
go get -u github.com/go-playground/validator/v10@latest
```

## Neovim Integration

Your Neovim config already has LSP support configured. Ensure these are set:

### Required Neovim Plugins

Already configured in `lua/plugins/lspconfig.lua`:
- nvim-lspconfig
- mason.nvim
- mason-lspconfig.nvim

### LSP Servers in Mason

Open Neovim and ensure gopls is installed:
```vim
:Mason
```

Look for and install:
- gopls

### DAP (Debug Adapter Protocol)

If using the debugger in Neovim, you'll need:
- nvim-dap
- nvim-dap-go
- nvim-dap-ui (optional)

Install delve (already covered above):
```bash
go install github.com/go-delve/delve/cmd/dlv@latest
```

## Environment Variables Checklist

Ensure these are set in your `~/.zshrc`:

```bash
# Go binary location
export PATH=$PATH:/usr/local/go/bin

# Go workspace
export GOPATH=$HOME/go

# Go tools and binaries
export PATH=$PATH:$GOPATH/bin
```

## Verification Steps

After installation, verify everything is working:

### 1. Check Go Installation
```bash
go version
# Expected: go version go1.23.4 linux/amd64 (or similar)
```

### 2. Check Go Environment
```bash
go env GOPATH GOROOT
# GOPATH should be /home/yourusername/go
# GOROOT should be /usr/local/go
```

### 3. Verify Tools Are in PATH
```bash
which gopls
which golangci-lint
which dlv
which goimports
which air
which cobra-cli
```

All should return paths like `/home/yourusername/go/bin/toolname`

### 4. Test LSP in Neovim
```bash
# Create a test Go file
mkdir -p /tmp/gotest
cd /tmp/gotest
go mod init test

# Create main.go
cat > main.go << 'EOF'
package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}
EOF

# Open in Neovim
nvim main.go
```

In Neovim:
- LSP should start automatically
- Hover over `fmt` and press `K` - should show documentation
- Type checking should work
- Auto-completion should work with `Ctrl+Space`

### 5. Test Go Compilation
```bash
go run main.go
# Expected: Hello, World!

go build
./test
# Expected: Hello, World!
```

## Optional: Database Setup

If working with databases, you'll need the actual database servers:

### PostgreSQL
```bash
sudo pacman -S postgresql
sudo -u postgres initdb -D /var/lib/postgres/data
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

### MySQL/MariaDB
```bash
sudo pacman -S mariadb
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mysql_secure_installation
```

## Troubleshooting

### "go: command not found"

Add Go to PATH in `~/.zshrc`:
```bash
export PATH=$PATH:/usr/local/go/bin
source ~/.zshrc
```

### "gopls: command not found" in Neovim

Ensure `$GOPATH/bin` is in PATH:
```bash
export PATH=$PATH:$HOME/go/bin
source ~/.zshrc
```

Restart Neovim after updating PATH.

### Permission Denied

If you get permission errors during installation:
```bash
# Check ownership of Go directory
ls -la /usr/local/go

# Check ownership of GOPATH
ls -la $HOME/go

# Fix GOPATH ownership if needed
chown -R $USER:$USER $HOME/go
```

### LSP Not Starting in Neovim

1. Check gopls is installed:
   ```bash
   which gopls
   gopls version
   ```

2. Check Neovim LSP status:
   ```vim
   :LspInfo
   ```

3. Check Mason:
   ```vim
   :Mason
   ```

4. Reinstall gopls:
   ```bash
   go install golang.org/x/tools/gopls@latest
   ```

## Quick Reference

### Update All Go Tools
```bash
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install golang.org/x/tools/cmd/goimports@latest
go install honnef.co/go/tools/cmd/staticcheck@latest
go install github.com/fatih/gomodifytags@latest
go install github.com/josharian/impl@latest
go install github.com/cweill/gotests/gotests@latest
go install github.com/air-verse/air@latest
go install github.com/spf13/cobra-cli@latest
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b "$HOME/go/bin" latest
```

### Clean Go Cache
```bash
go clean -cache
go clean -modcache
```

### Check Go Module Status
```bash
go mod tidy
go mod verify
```

## Resources

- [Official Go Documentation](https://go.dev/doc/)
- [Go Installation Guide](https://go.dev/doc/install)
- [gopls Documentation](https://github.com/golang/tools/tree/master/gopls)
- [golangci-lint Linters](https://golangci-lint.run/usage/linters/)
- [Delve Debugger Guide](https://github.com/go-delve/delve)
