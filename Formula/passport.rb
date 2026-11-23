# Written by passport-desktop's release workflow (scripts/homebrew.sh).
# Edits here are replaced on the next release.
class Passport < Formula
  desc "Headless Passport on one computer: server, web apps, inbox, Stripe simulator"
  homepage "https://github.com/libatomic/passport-releases"
  # A url outside on_linux, so the formula also loads on macOS (Homebrew
  # reads every formula in the tap there); depends_on stops an install.
  url "https://github.com/libatomic/passport-releases/releases/download/v2.3.0-rc.9/passport-2.3.0-rc.9-linux-amd64.tar.gz"
  version "2.3.0-rc.9"
  sha256 "5213b76f82430d88e5a2cb404027c98c19677a41406f321b4138550d922ea56e"

  depends_on :linux

  on_linux do
    on_arm do
      url "https://github.com/libatomic/passport-releases/releases/download/v2.3.0-rc.9/passport-2.3.0-rc.9-linux-arm64.tar.gz"
      sha256 "94aeb668f8d990be55777af995ce2502fc56e51972c7dfc132e15c89e52cd487"
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

      With Passport running, `passport trust` adds its local certificate
      (only good for .localhost) to your browsers (needs certutil, from
      libnss3-tools or nss-tools) and to the system store (asks for your
      password).

      On macOS, install the app instead:
        brew install --cask libatomic/tap/passport
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/passport version")
  end
end
