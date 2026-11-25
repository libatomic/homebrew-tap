# Written by passport-desktop's release workflow (scripts/homebrew.sh).
# Edits here are replaced on the next release.
cask "passport" do
  version "2.3.0-rc.10"
  sha256 "19696472e19975399261b98a476e822a9b266cec83f39a8ba32b947e7e842efb"

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
