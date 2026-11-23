# Written by passport-desktop's release workflow (scripts/homebrew.sh).
# Edits here are replaced on the next release.
cask "passport" do
  version "2.3.0-rc.7"
  sha256 "e6bfa2f5d2e51ebcb74b5951f1b37f254732d683f839210fc3ecc0ed0cf8972d"

  url "https://github.com/libatomic/passport-releases/releases/download/v#{version}/Passport-#{version}-arm64-unsigned.dmg"
  name "Passport"
  desc "Whole Passport on one computer: server, web apps, inbox, Stripe simulator"
  homepage "https://github.com/libatomic/passport-releases"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Passport.app"
  binary "#{appdir}/Passport.app/Contents/Helpers/passport"

  zap trash: "~/Library/Application Support/Passport"

  caveats <<~EOS
    This build of Passport is not signed. macOS will refuse to open it until
    its quarantine flag is cleared:

      xattr -dr com.apple.quarantine "#{appdir}/Passport.app"
  EOS
end
