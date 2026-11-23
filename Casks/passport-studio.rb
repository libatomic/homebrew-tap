# Written by the release workflow of Passport Studio. Do not edit.
cask "passport-studio" do
  version "0.1.0-rc.3"
  sha256 "6de77b659dbd2f543510293533944c94027e8ef4ae496c448fc2564f458bb68c"

  url "https://github.com/libatomic/passport-releases/releases/download/studio-v#{version}/Passport-Studio-#{version}-macos-arm64.dmg"
  name "Passport Studio"
  desc "Build, test and release Passport plugins"
  homepage "https://github.com/libatomic/passport-releases"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "Passport Studio.app"

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
  EOS
end
