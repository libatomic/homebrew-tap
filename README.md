# Homebrew Tap for Passport

Official [Homebrew](https://brew.sh) tap for Passport: `atomic-cli`, the command line for a Passport instance, plus Passport desktop and Passport Studio. Downloads come from [libatomic/passport-releases](https://github.com/libatomic/passport-releases).

## Installation

```bash
# Add the tap
brew tap libatomic/tap

# Install atomic-cli
brew install libatomic/tap/atomic-cli
```

## Upgrading

```bash
brew update
brew upgrade libatomic/tap/atomic-cli
```

## Verify

```bash
atomic-cli --version
```

## Available Formulas

| Formula | Description |
|---------|-------------|
| `atomic-cli` | CLI for managing Atomic instances, users, plans, subscriptions, migrations, and more |
| `passport` | Passport desktop, headless (Linux x64 and arm64): the whole Passport on one computer |

| Cask | Description |
|------|-------------|
| `passport` | Passport desktop for macOS (Apple silicon and Intel), with the `passport` command line on the PATH |
| `passport-studio` | Passport Studio for macOS (Apple silicon): build, test and release Passport plugins |

### Passport desktop

```bash
# macOS: the app
brew install --cask libatomic/tap/passport

# Linux: the headless command line
brew install libatomic/tap/passport
passport up --headless
```

The cask and formula are written by passport-desktop's release workflow on
each release; downloads come from
[libatomic/passport-releases](https://github.com/libatomic/passport-releases).
They appear here with the first published release.

### Passport Studio

```bash
brew install --cask libatomic/tap/passport-studio
```

Apple silicon Macs on macOS 12 or later. `brew upgrade --cask passport-studio`
moves to the newest release and `brew uninstall --cask passport-studio`
removes the app; plugin projects are kept where you put them.

The cask is written by Passport Studio's release workflow on each release,
release candidates included; downloads come from
[libatomic/passport-releases](https://github.com/libatomic/passport-releases).
Until the builds are signed by Apple the cask clears the download's
quarantine flag after installing, so the app opens.

For Linux and Windows, download the `.deb`, `.AppImage` or installer from
[the releases](https://github.com/libatomic/passport-releases/releases); they
are tagged `studio-v<version>`.

## Supported Platforms

| Platform | Architecture |
|----------|-------------|
| macOS | Apple Silicon (arm64) |
| macOS | Intel (x86_64) |
| Linux | arm64 |
| Linux | x86_64 |

## Quick Start

After installing, configure your credentials:

```bash
# Create credentials file
mkdir -p ~/.atomic
cat > ~/.atomic/credentials << 'EOF'
[default]
host = "api.example.com"
access_token = "your_token_here"
instance_id = "your_instance_id"
EOF
```

Or use environment variables:

```bash
export ATOMIC_API_HOST="api.example.com"
export ATOMIC_ACCESS_TOKEN="your_token_here"
export ATOMIC_INSTANCE_ID="your_instance_id"
```

Then start using the CLI:

```bash
# List users
atomic-cli -i your_instance user list

# Import data from another instance
atomic-cli -i target_instance import \
  --remote-host api.source.com \
  --remote-token xxx \
  --types categories,plans,audiences

# Migrate Substack subscribers
atomic-cli migrate substack \
  --stripe-key sk_live_xxx \
  --email-template "test+{{seq}}@example.com" \
  --limit 10
```

## Documentation

`atomic-cli --help` lists every command, and `atomic-cli setup` installs the skills that teach AI coding agents to use it.

The formula is written by atomic-cli's release workflow on each final release. Release candidates are not in the tap; they are on [the releases page](https://github.com/libatomic/passport-releases/releases), tagged `cli-v<version>`.

## License

See [LICENSE](LICENSE) for details.
