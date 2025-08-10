require "formula"
require_relative "../custom_download_strategy.rb"

class AtomicCli < Formula
  env :std
  
  desc "A command-line tool for Atomic"
  homepage "https://github.com/libatomic/atomic-cli"
  url "https://github.com/libatomic/atomic-cli/archive/refs/tags/v0.0.3.tar.gz", :using => GitHubPrivateRepositoryDownloadStrategy 
  sha256 "bc7d4da2282c348b6975d756070963913dfc9dd4feb0816347683a8922fc845c"
  license "MIT"

  depends_on "go" => :build

  # Additional dependency
  # resource "" do
  #   url ""
  #   sha256 ""
  # end

  def install
  # 1) Get token from environment (Brew may filter; pass inline if needed)
    token = ENV["HOMEBREW_GITHUB_API_TOKEN"]
    token = ENV["GITHUB_TOKEN"] if token.to_s.empty?
    token = ENV["GH_TOKEN"]      if token.to_s.empty?
    odie "Token required for private modules (set HOMEBREW_GITHUB_API_TOKEN / GITHUB_TOKEN / GH_TOKEN)" if token.to_s.empty?

    # 2) Go env so it fetches modules directly from GitHub and treats your org as private
    ENV["GOPRIVATE"]          = "github.com/libatomic/*"
    ENV["GONOSUMDB"]          = "github.com/libatomic/*"
    ENV["GONOPROXY"]          = "github.com/libatomic/*"
    ENV["GOPROXY"]            = "direct"
    ENV["GOSUMDB"]            = "off"           # avoid remote checksum DB for private
    ENV["GIT_TERMINAL_PROMPT"] = "0"            # fail fast if auth is wrong

    # 3) Make sure git config lands in a writable HOME that go's git will read
    ENV["HOME"] = buildpath

    # 4) Rewrite all https://github.com/… to include the token (Basic auth)
    #    The username can be anything; :x-oauth-basic is a common convention.
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
