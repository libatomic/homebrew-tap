# Formula/atomic-cli.rb
require_relative "../custom_download_strategy"

class AtomicCli < Formula
  desc "A command-line tool for Atomic"
  homepage "https://github.com/libatomic/atomic-cli"
  license "MIT"

  # macOS
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.16/atomic-cli_Darwin_arm64.tar.gz"
      sha256 "ed85b2d1b9a008ea06a585437c84cb5581fc3049de6fff1b76e8652b7b5e1bf3"
    else
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.16/atomic-cli_Darwin_amd64.tar.gz"
      sha256 "a0b668a09cbec6e7ec685278256e21a9f4476013637e1eb12e84955aed86fc1b"
    end
  end

  # Linux
  on_linux do
    if Hardware::CPU.arm?
      # Adjust to armv7/armhf if that's what you ship; otherwise arm64/aarch64
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.16/atomic-cli_Linux_arm64.tar.gz"
      sha256 "b03777a06ffc2c3ce1b36a9937032e33f7b784a8f96a38e80e273b403f304849"
    else
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.16/atomic-cli_Linux_amd64.tar.gz"
      sha256 "8eff78caf179d9a32b48c2376803f8fb832bbe854648f773ae6cf477e06bac39"
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