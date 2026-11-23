# Written by passport-desktop's release workflow (scripts/homebrew.sh).
# Edits here are replaced on the next release.
class Passport < Formula
  desc "Headless Passport on one computer: server, web apps, inbox, Stripe simulator"
  homepage "https://github.com/libatomic/passport-releases"
  version "2.3.0-rc.7"

  depends_on :linux

  on_linux do
    on_intel do
      url "https://github.com/libatomic/passport-releases/releases/download/v2.3.0-rc.7/passport-2.3.0-rc.7-linux-amd64.tar.gz"
      sha256 "708a5bd41160b19c758024df4e7f529a339c2f996505bd6640202a90e6623328"
    end

    on_arm do
      url "https://github.com/libatomic/passport-releases/releases/download/v2.3.0-rc.7/passport-2.3.0-rc.7-linux-arm64.tar.gz"
      sha256 "18b799a3fc8c80be05ce208eac30e9ee8d190ef32289f8798c1775929c45b1a6"
    end
  end

  def install
    # passport finds Helpers and Resources beside its bin folder, through the
    # symlink, so the archive is kept whole.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/passport"
  end

  def caveats
    <<~EOS
      Run Passport with:
        passport up --headless

      Trusting its local certificate automatically is macOS only for now.
      Import the file `passport ca --path` prints into your browser, or
      point your tools at it.

      On macOS, install the app instead:
        brew install --cask libatomic/tap/passport
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/passport version")
  end
end
