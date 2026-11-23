# Written by passport-desktop's release workflow (scripts/homebrew.sh).
# Edits here are replaced on the next release.
cask "passport" do
  version "2.3.0-rc.8"
  sha256 "47104d4568046db7ef185603679b3b7d770f4948ddb355f6999ef0dd421cc459"

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
