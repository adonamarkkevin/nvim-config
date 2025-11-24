#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
INSTALL_DIR="/usr/local"
GOPATH="$HOME/go"

echo_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

echo_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

echo_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Get latest Go version
get_latest_go_version() {
    echo_info "Fetching latest Go version..."

    # Fetch the latest version from Go's download page
    GO_VERSION=$(curl -sL 'https://go.dev/VERSION?m=text' | head -n 1 | sed 's/go//')

    if [ -z "$GO_VERSION" ]; then
        echo_error "Failed to fetch latest Go version"
        exit 1
    fi

    echo_info "Latest Go version: ${GO_VERSION}"

    GO_TAR="go${GO_VERSION}.linux-amd64.tar.gz"
    GO_URL="https://go.dev/dl/${GO_TAR}"
}

# Check if running as root for system-wide install
check_permissions() {
    if [ "$EUID" -eq 0 ]; then
        echo_warn "Running as root. Go will be installed system-wide."
        SYSTEM_INSTALL=true
    else
        echo_info "Running as user. Will attempt sudo for system install."
        SYSTEM_INSTALL=false
    fi
}

# Install Go binary
install_go_binary() {
    # Check if Go is already installed
    if command -v go &> /dev/null; then
        CURRENT_VERSION=$(go version | awk '{print $3}' | sed 's/go//')
        echo_info "Go ${CURRENT_VERSION} is already installed. Skipping Go installation."
        echo_warn "If you want to upgrade to ${GO_VERSION}, manually remove the existing installation first."
        return 0
    fi

    echo_info "Installing Go ${GO_VERSION}..."

    # Download Go
    echo_info "Downloading Go from ${GO_URL}..."
    cd /tmp
    wget -q --show-progress "${GO_URL}" || {
        echo_error "Failed to download Go"
        exit 1
    }

    # Remove old installation if it exists but go command wasn't found
    if [ -d "${INSTALL_DIR}/go" ]; then
        echo_info "Removing old Go installation..."
        if [ "$SYSTEM_INSTALL" = true ]; then
            rm -rf "${INSTALL_DIR}/go"
        else
            sudo rm -rf "${INSTALL_DIR}/go"
        fi
    fi

    # Extract and install
    echo_info "Installing Go to ${INSTALL_DIR}..."
    if [ "$SYSTEM_INSTALL" = true ]; then
        tar -C "${INSTALL_DIR}" -xzf "${GO_TAR}"
    else
        sudo tar -C "${INSTALL_DIR}" -xzf "${GO_TAR}"
    fi

    # Cleanup
    rm "${GO_TAR}"

    echo_info "Go ${GO_VERSION} installed successfully!"
}

# Setup Go environment
setup_go_environment() {
    echo_info "Setting up Go environment..."

    # Create GOPATH directory
    if [ ! -d "$GOPATH" ]; then
        mkdir -p "$GOPATH"/{bin,src,pkg}
        echo_info "Created GOPATH at $GOPATH"
    fi

    # Check if PATH is already configured in .zshrc
    if ! grep -q "/usr/local/go/bin" "$HOME/.zshrc" 2>/dev/null; then
        echo_info "Adding Go to PATH in .zshrc..."
        cat >> "$HOME/.zshrc" << 'EOF'

# Go environment
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
EOF
    else
        echo_info "Go PATH already configured in .zshrc"
    fi

    # Export for current session
    export GOPATH=$HOME/go
    export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

    echo_info "Go environment configured!"
}

# Install Go LSP and development tools
install_go_tools() {
    echo_info "Installing Go LSP servers and development tools..."

    # Ensure PATH is set for this script
    export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

    # gopls - Official Go Language Server
    echo_info "Installing gopls (Go Language Server)..."
    go install golang.org/x/tools/gopls@latest

    # golangci-lint - Fast linters runner
    echo_info "Installing golangci-lint..."
    curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b "$GOPATH/bin" latest

    # delve - Go debugger
    echo_info "Installing delve (Go debugger)..."
    go install github.com/go-delve/delve/cmd/dlv@latest

    # goimports - Auto format imports
    echo_info "Installing goimports..."
    go install golang.org/x/tools/cmd/goimports@latest

    # staticcheck - Advanced static analysis
    echo_info "Installing staticcheck..."
    go install honnef.co/go/tools/cmd/staticcheck@latest

    # gomodifytags - Modify struct tags
    echo_info "Installing gomodifytags..."
    go install github.com/fatih/gomodifytags@latest

    # impl - Generate interface implementations
    echo_info "Installing impl..."
    go install github.com/josharian/impl@latest

    # gotests - Generate tests
    echo_info "Installing gotests..."
    go install github.com/cweill/gotests/gotests@latest

    # air - Live reload for Go apps
    echo_info "Installing air (live reload)..."
    go install github.com/air-verse/air@latest

    echo_info "Go tools installed successfully!"
}

# Install common Go libraries and frameworks
install_common_libraries() {
    echo_info "Installing common Go libraries and frameworks..."

    export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

    # Create a temporary module to install tools
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    go mod init temp

    # CLI frameworks
    echo_info "Installing cobra (CLI framework)..."
    go get -u github.com/spf13/cobra@latest

    echo_info "Installing cobra-cli (CLI generator)..."
    go install github.com/spf13/cobra-cli@latest

    # Web frameworks
    echo_info "Installing gin (web framework)..."
    go get -u github.com/gin-gonic/gin@latest

    echo_info "Installing echo (web framework)..."
    go get -u github.com/labstack/echo/v4@latest

    # Database drivers
    echo_info "Installing PostgreSQL driver..."
    go get -u github.com/lib/pq@latest

    echo_info "Installing MySQL driver..."
    go get -u github.com/go-sql-driver/mysql@latest

    # ORM
    echo_info "Installing gorm (ORM)..."
    go get -u gorm.io/gorm@latest
    go get -u gorm.io/driver/postgres@latest
    go get -u gorm.io/driver/mysql@latest

    # Utilities
    echo_info "Installing viper (configuration)..."
    go get -u github.com/spf13/viper@latest

    echo_info "Installing logrus (logging)..."
    go get -u github.com/sirupsen/logrus@latest

    echo_info "Installing testify (testing)..."
    go get -u github.com/stretchr/testify@latest

    echo_info "Installing validator (validation)..."
    go get -u github.com/go-playground/validator/v10@latest

    # Cleanup
    cd - > /dev/null
    rm -rf "$TEMP_DIR"

    echo_info "Common libraries installed successfully!"
}

# Verify installation
verify_installation() {
    echo_info "Verifying installation..."

    export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

    echo ""
    echo "Go version:"
    go version

    echo ""
    echo "Go environment:"
    go env GOPATH GOROOT

    echo ""
    echo "Installed tools:"
    command -v gopls && echo "  ✓ gopls"
    command -v golangci-lint && echo "  ✓ golangci-lint"
    command -v dlv && echo "  ✓ delve"
    command -v goimports && echo "  ✓ goimports"
    command -v staticcheck && echo "  ✓ staticcheck"
    command -v gomodifytags && echo "  ✓ gomodifytags"
    command -v impl && echo "  ✓ impl"
    command -v gotests && echo "  ✓ gotests"
    command -v air && echo "  ✓ air"
    command -v cobra-cli && echo "  ✓ cobra-cli"

    echo ""
    echo_info "Installation complete!"
    echo_warn "Please restart your shell or run: source ~/.zshrc"
}

# Main installation flow
main() {
    echo_info "Starting Go development environment setup..."
    echo ""

    get_latest_go_version
    check_permissions
    install_go_binary
    setup_go_environment
    install_go_tools
    install_common_libraries
    verify_installation

    echo ""
    echo_info "All done! Happy coding! 🚀"
}

main
