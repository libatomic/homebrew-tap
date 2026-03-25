# Formula/atomic-cli.rb
require_relative "../custom_download_strategy"

class AtomicCli < Formula
  desc "A command-line tool for Atomic"
  homepage "https://github.com/libatomic/atomic-cli"
  license "MIT"

  # macOS
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.18/atomic-cli_Darwin_arm64.tar.gz"
      sha256 "2678577f1e47ef906cf1890bbec36d889b39890da9996aa6372c6975e8ae9187"
    else
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.18/atomic-cli_Darwin_x86_64.tar.gz"
      sha256 "ffaf08597928d6905ea8de88e45618b90abdfaeadccf4732fe10c2a11a6a89c5"
    end
  end

  # Linux
  on_linux do
    if Hardware::CPU.arm?
      # Adjust to armv7/armhf if that's what you ship; otherwise arm64/aarch64
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.18/atomic-cli_Linux_arm64.tar.gz"
      sha256 "035dce7d4b074b97757152a9c743ca9975c9e3dc75b92dd30248bbfb32e379d5"
    else
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.18/atomic-cli_Linux_x86_64.tar.gz"
      sha256 "30c8ee119b7b8b3e2dae0b3d12c7b66c3c075b2b99dfe65cf8cd9cf6dd5533fd"
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