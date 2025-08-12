# Formula/atomic-cli.rb
require_relative "../custom_download_strategy"

class AtomicCli < Formula
  desc "A command-line tool for Atomic"
  homepage "https://github.com/libatomic/atomic-cli"
  license "MIT"

  # macOS
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.11/atomic-cli_Darwin_arm64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "fb53388b7dc3cb580289aaf755c6323630d2d6ba94d90cfe433b5ac62e4bd6df"
    else
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.11/atomic-cli_Darwin_amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "dff4f785ac5ca4ad422e1b0394b4bc6aa99b963bf4cc82cce96b295fdd27d750"
    end
  end

  # Linux
  on_linux do
    if Hardware::CPU.arm?
      # Adjust to armv7/armhf if that's what you ship; otherwise arm64/aarch64
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.11/atomic-cli_Linux_arm64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "9ce631ae08a584f0655fb58974f75129117d2e29aa7a13b68199ebda6fe46bf6"
    else
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.11/atomic-cli_Linux_amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "eb6a7738cebbd46d906e2f5f9e05fb8497efc41c72876b860aebdf8c351964a2"
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