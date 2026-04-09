# Formula/atomic-cli.rb
require_relative "../custom_download_strategy"

class AtomicCli < Formula
  desc "A command-line tool for Atomic"
  homepage "https://github.com/libatomic/atomic-cli"
  license "MIT"

  # macOS
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.19/atomic-cli_Darwin_arm64.tar.gz"
      sha256 "f1b204830d072ae92b817a4a788bea9b9a401711ba375c62c69c8aa332d6cdbf"
    else
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.19/atomic-cli_Darwin_x86_64.tar.gz"
      sha256 "6d903e94f06970f0f93c78341e41bd2c303ef7651b00ce9b1dfb066848436d4c"
    end
  end

  # Linux
  on_linux do
    if Hardware::CPU.arm?
      # Adjust to armv7/armhf if that's what you ship; otherwise arm64/aarch64
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.19/atomic-cli_Linux_arm64.tar.gz"
      sha256 "1b49678a1d0296c48ae5193971bac6adb19b5a9294b8af868e91ab21eb63290e"
    else
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.19/atomic-cli_Linux_x86_64.tar.gz"
      sha256 "ccf9304e43f64edeb73c07ecf51981cfea98fd7b647c498ea8daefe137879df0"
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