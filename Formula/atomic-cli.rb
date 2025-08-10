# Formula/atomic-cli.rb
require_relative "../custom_download_strategy"

class AtomicCli < Formula
  desc "A command-line tool for Atomic"
  homepage "https://github.com/libatomic/atomic-cli"
  license "MIT"

  # macOS
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.4/atomic-cli_Darwin_arm64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "sha256:294ee7add7bbaa3f7c189daf5a442967547b435e03cb46e6114ecbf35304c25d"
    else
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.4/atomic-cli_Darwin_amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "sha256:d6088af97ac497643d4469b544e3bd1a5d5176ec1fcd7f90094fe7b7e5539f77"
    end
  end

  # Linux
  on_linux do
    if Hardware::CPU.arm?
      # Adjust to armv7/armhf if that's what you ship; otherwise arm64/aarch64
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.4/atomic-cli_Linux_arm64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "sha256:671afec2028d1df5caf66bc3c96c5c04b8422e358bae4ad170844dea0e53deed"
    else
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.4/atomic-cli_Linux_amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "sha256:2b9995c9df0eb78dc54f617c2448ce542274ea8fe74ea56659a829356f5aa94a"
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