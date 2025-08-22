# Formula/atomic-cli.rb
require_relative "../custom_download_strategy"

class AtomicCli < Formula
  desc "A command-line tool for Atomic"
  homepage "https://github.com/libatomic/atomic-cli"
  license "MIT"

  # macOS
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/libatomic/atomic-cli/releases/download/v1.0.10-alpha.28/atomic-cli_Darwin_arm64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "d26670d06a22a4d45069d929fa180bf2984093c140b7c51a204d957a34c3f976"
    else
      url "https://github.com/libatomic/atomic-cli/releases/download/v1.0.10-alpha.28/atomic-cli_Darwin_amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "9c9d8bed186c00d7d16e0ff7615ae32815d859be15c2649d01d19184c7a7b17e"
    end
  end

  # Linux
  on_linux do
    if Hardware::CPU.arm?
      # Adjust to armv7/armhf if that's what you ship; otherwise arm64/aarch64
      url "https://github.com/libatomic/atomic-cli/releases/download/v1.0.10-alpha.28/atomic-cli_Linux_arm64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "51b86ab1b32036363b711f48a24f3cff97f568029c369f38aa6e66240cb19daf"
    else
      url "https://github.com/libatomic/atomic-cli/releases/download/v1.0.10-alpha.28/atomic-cli_Linux_amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "04794aec3715dfba60138371d796b423521777fc6d6a683e41c2db0daee78485"
    end
  end

  def install
    # If your tarball unpacks to just the binary:
    bin.install "atomic-cli"

    # If your tarball contains a folder (e.g., ./atomic-cli/atomic-cli):
    # Dir["*"].each { |f| ohai "Unpacked: #{f}" }  # debug once
    # bin.install Dir["**/atomic-cli"].first
  end

  test do
    # Prefer --version if your binary supports it
    output = shell_output("#{bin}/atomic-cli --help", 2)
    assert_match "atomic", output
  end
end