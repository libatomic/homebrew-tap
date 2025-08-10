require "formula"
require_relative "../custom_download_strategy.rb"

class AtomicCli < Formula  
  desc "A command-line tool for Atomic"
  homepage "https://github.com/libatomic/atomic-cli"
  url "https://github.com/libatomic/atomic-cli/archive/refs/tags/v0.0.4.tar.gz", :using => GitHubPrivateRepositoryDownloadStrategy 
  sha256 "267571dfec75daaaf15a032a3c008f0f75fdfd4d7fd31f17fe52e389bfd1df2a"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["GOPRIVATE"]  = "github.com/libatomic/*"
    ENV["GONOSUMDB"]  = "github.com/libatomic/*"
    ENV["GONOPROXY"]  = "github.com/libatomic/*"
    ENV["GOPROXY"]    = "direct"
    ENV["GOSUMDB"]    = "off"
    ENV["GIT_TERMINAL_PROMPT"] = "1"
    ENV["HOME"] = Dir.home
    ENV["GIT_CONFIG_GLOBAL"] = File.expand_path("~/.gitconfig")

    system "go", "build", *std_go_args(ldflags: "-s -w"), "cmd/atomic-cli/main.go"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test atomic-cli`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    system "false"
  end
end
