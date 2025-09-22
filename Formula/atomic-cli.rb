# Formula/atomic-cli.rb
require_relative "../custom_download_strategy"

class AtomicCli < Formula
  desc "A command-line tool for Atomic"
  homepage "https://github.com/libatomic/atomic-cli"
  license "MIT"

  # macOS
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.17/atomic-cli_Darwin_arm64.tar.gz"
      sha256 "0c99e2a06ad34b29ec09f6c2f26eff62d3e07c9d606fb5ab4c64880be8b207d7"
    else
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.17/atomic-cli_Darwin_amd64.tar.gz"
      sha256 "4ca7a2a3369cf73ca17d5cb2b2cd0f93c043e385edadf41ddf97904879c650cb"
    end
  end

  # Linux
  on_linux do
    if Hardware::CPU.arm?
      # Adjust to armv7/armhf if that's what you ship; otherwise arm64/aarch64
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.17/atomic-cli_Linux_arm64.tar.gz"
      sha256 "bd849bb89dcccbcaa92839deaf778fb3c96d90f31eb28bcd225e72bee51ae76e"
    else
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.17/atomic-cli_Linux_amd64.tar.gz"
      sha256 "5bcd68d48781e62f11f81cf3742e9bafe9eb23aa10fbea94c6dc542e08283480"
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