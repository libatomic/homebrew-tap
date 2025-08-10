require "formula"
require_relative "../custom_download_strategy.rb"

class AtomicCli < Formula
  desc "A command-line tool for Atomic"
  homepage "https://github.com/libatomic/atomic-cli"
  url "https://github.com/libatomic/atomic-cli/archive/refs/tags/v0.0.2.tar.gz", :using => GitHubPrivateRepositoryDownloadStrategy 
  sha256 "2cea8136da96d05143b2603b1fe7afcedb0fde78ea0ab801d30897390cc24816"
  license "MIT"

  depends_on "go" => :build

  # Additional dependency
  # resource "" do
  #   url ""
  #   sha256 ""
  # end

  def install
    token = ENV["HOMEBREW_GITHUB_API_TOKEN"]
    odie "HOMEBREW_GITHUB_API_TOKEN is required for private modules" if token.to_s.empty?

    ENV["GOPRIVATE"]  = "github.com/libatomic/*"
    ENV["GONOSUMDB"]  = "github.com/libatomic/*"
    ENV["GONOPROXY"]  = "github.com/libatomic/*"
    ENV["GOPROXY"]    = "direct"
    ENV["GIT_TERMINAL_PROMPT"] = "0" 

    ENV["HOME"] = buildpath # make --global write into the build sandbox
    system "git", "config", "--global",
           "url.https://#{token}:x-oauth-basic@github.com/.insteadof", "https://github.com/"


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
