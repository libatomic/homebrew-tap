# Written by the release workflow of Passport Studio. Do not edit.
cask "passport-studio" do
  version "0.1.0-rc.2"
  sha256 "3915ea4a6ad1a36680557494a7cffd23d715d3ae4d744386508d2703db104aeb"

  url "https://github.com/libatomic/passport-releases/releases/download/studio-v#{version}/Passport-Studio-#{version}-macos-arm64.dmg"
  name "Passport Studio"
  desc "Build, test and release Passport plugins"
  homepage "https://github.com/libatomic/passport-releases"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "Passport Studio.app"

  # This build is not signed. macOS will not open an unsigned download until
  # its quarantine flag is cleared.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/Passport Studio.app"]
  end

  zap trash: [
    "~/Library/Application Support/dev.pspt.plugin-studio",
    "~/Library/Caches/dev.pspt.plugin-studio",
    "~/Library/Preferences/dev.pspt.plugin-studio.plist",
    "~/Library/Saved Application State/dev.pspt.plugin-studio.savedState",
    "~/Library/WebKit/dev.pspt.plugin-studio",
  ]

  caveats <<~EOS
    Plugin projects are kept where you put them and are not removed with
    the app.

    This build is not signed by Apple. Homebrew cleared its quarantine flag
    so that it opens.
  EOS
end
