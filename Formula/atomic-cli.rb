# Formula/atomic-cli.rb
require_relative "../custom_download_strategy"

class AtomicCli < Formula
  desc "A command-line tool for Atomic"
  homepage "https://github.com/libatomic/atomic-cli"
  license "MIT"

  # macOS
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.13/atomic-cli_Darwin_arm64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "d5b96424ae4f4e163a6a7d02bd0dc716e5f073ec7a4e489a04685ec3fbcf7fb2"
    else
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.13/atomic-cli_Darwin_amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "316d09451e6e4b14c06a9f5eea40874afe4cfa61f2d3111e7d691e38b921bdb4"
    end
  end

  # Linux
  on_linux do
    if Hardware::CPU.arm?
      # Adjust to armv7/armhf if that's what you ship; otherwise arm64/aarch64
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.13/atomic-cli_Linux_arm64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "fbe87aeabe7295dd8af48e1ce699941e7dd4cc643b3a1180b3861ca3c93508b8"
    else
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.13/atomic-cli_Linux_amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "2db35b599565f38da6e7b1cb23b51966b4694fe1f30139bc8f76ec99a54a6225"
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