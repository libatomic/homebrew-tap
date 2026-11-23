# Written by passport-desktop's release workflow (scripts/homebrew.sh).
# Edits here are replaced on the next release.
cask "passport" do
  version "2.3.0-rc.9"
  sha256 "16913541f8d4efa86ba7bf9f5eb4aba9ee06fac5f228a9a7aa99431cd962c98d"

  url "https://github.com/libatomic/passport-releases/releases/download/v#{version}/Passport-#{version}-arm64.dmg"
  name "Passport"
  desc "Whole Passport on one computer: server, web apps, inbox, Stripe simulator"
  homepage "https://github.com/libatomic/passport-releases"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Passport.app"
  binary "#{appdir}/Passport.app/Contents/Helpers/passport"

  zap trash: "~/Library/Application Support/Passport"

end
