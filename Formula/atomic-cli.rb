# Formula/atomic-cli.rb
require_relative "../custom_download_strategy"

class AtomicCli < Formula
  desc "A command-line tool for Atomic"
  homepage "https://github.com/libatomic/atomic-cli"
  license "MIT"

  # macOS
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.10/atomic-cli_Darwin_arm64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "65a603349d5974c064f42da1ef44812f7d3d617b0fc442e256b67a47f09087f8"
    else
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.10/atomic-cli_Darwin_amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "8ba7168a9b46c109b285fc4390b04a560691b7c642b7a6748e75e6491c33947f"
    end
  end

  # Linux
  on_linux do
    if Hardware::CPU.arm?
      # Adjust to armv7/armhf if that's what you ship; otherwise arm64/aarch64
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.10/atomic-cli_Linux_arm64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "02b10493213d365eb444cdaa47782eeabd04fabd8a13158f1241daafd27f699e"
    else
      url "https://github.com/libatomic/atomic-cli/releases/download/v0.0.10/atomic-cli_Linux_amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "ade711fcacf0b80f4cad405e56ab312fdc5c2dd05a547e25b492d45a2cb6865e"
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