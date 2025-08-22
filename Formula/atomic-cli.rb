# Formula/atomic-cli.rb
require_relative "../custom_download_strategy"

class AtomicCli < Formula
  desc "A command-line tool for Atomic"
  homepage "https://github.com/libatomic/atomic-cli"
  license "MIT"

  # macOS
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.14/atomic-cli_Darwin_arm64.tar.gz"
      sha256 "44647c213d4c8fe4a1264939cabfdaa1187c432b0e42b0a197814847b908c897"
    else
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.14/atomic-cli_Darwin_amd64.tar.gz"
      sha256 "f1ebcbc375561b73ea3c9c4428f4d6dadb2de1c0a897036336d5fdd0b687f9b1"
    end
  end

  # Linux
  on_linux do
    if Hardware::CPU.arm?
      # Adjust to armv7/armhf if that's what you ship; otherwise arm64/aarch64
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.14/atomic-cli_Linux_arm64.tar.gz"
      sha256 "37c119a24a2ba34f38cada7bc2a64f2d7d55b63a2aeb2b50fb7a0113e644780f"
    else
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.14/atomic-cli_Linux_amd64.tar.gz"
      sha256 "fc79c5c34799243d1c3cc629931beb2ae581931bf4489893672429db72e6fcbf"
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