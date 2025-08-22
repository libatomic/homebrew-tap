# Formula/atomic-cli.rb
require_relative "../custom_download_strategy"

class AtomicCli < Formula
  desc "A command-line tool for Atomic"
  homepage "https://github.com/libatomic/atomic-cli"
  license "MIT"

  # macOS
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.15/atomic-cli_Darwin_arm64.tar.gz"
      sha256 "9c68ad770851d2ae208494cc738400693fe05366cb161d909b2f4e35f3e0d53a"
    else
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.15/atomic-cli_Darwin_amd64.tar.gz"
      sha256 "4a8e2b0afea7d76050c264868a30234d24c39a089308e8cd1c9c10e600647a19"
    end
  end

  # Linux
  on_linux do
    if Hardware::CPU.arm?
      # Adjust to armv7/armhf if that's what you ship; otherwise arm64/aarch64
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.15/atomic-cli_Linux_arm64.tar.gz"
      sha256 "db14ae9fb3276e6ca83b3bb7d3f5076002092db28798c8307b4ca65837314eee"
    else
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.15/atomic-cli_Linux_amd64.tar.gz"
      sha256 "cbffd6edf2304d21c1473b7b784894fe607261f209ccf1d2369627d9d118be10"
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