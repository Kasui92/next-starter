# Next-Starter

A command-line tool for initializing Next.js projects with some (**absolutely unsolicited and completely questionable**) best practice.

## Installation

### Automatic Installation

Run the installer script with sudo privileges:

```bash
sudo ./install.sh
```

This will install the `next-starter` command system-wide, making it available from any directory.

### Manual Installation

If the automatic installation fails, you can manually create a symbolic link:

```bash
sudo ln -sf /full/path/to/next-starter.sh /usr/local/bin/next-starter
```

### Requirements

- Bash shell
- Node.js and npm
- Git (optional, for repository initialization)

## Uninstallation

To remove the Next-Starter tool from your system:

```bash
sudo rm /usr/local/bin/next-starter
```

## Usage

```bash
# Create a project in the current directory
next-starter

# Create a project in a specific path
next-starter /path/to/project
```