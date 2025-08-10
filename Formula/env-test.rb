class EnvTest < Formula
    env :std
    desc "Test env passthrough"
    homepage "https://example.com"
    url "https://example.com/dummy.tar.gz"
    sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  
    def install
      ohai "HOMEBREW_GITHUB_API_TOKEN=#{ENV["HOMEBREW_GITHUB_API_TOKEN"]}"
      ohai "GITHUB_TOKEN=#{ENV["GITHUB_TOKEN"]}"
      ohai "GH_TOKEN=#{ENV["GH_TOKEN"]}"
      system "true"
    end
  end