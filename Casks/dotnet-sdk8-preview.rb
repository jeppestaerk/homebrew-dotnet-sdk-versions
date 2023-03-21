cask "dotnet-sdk8-preview" do
  arch arm: "arm64", intel: "x64"

  version "8.0.100-preview.2.23157.25"

  sha512_x64 = "246cc88f89638475d56384855825381990650464266ca8b0de17fdca5c90d16c8d2ce27aa27bd01250d7b9a12f7fa67bef5e49277fe4bcaecad831e3f8eddafd"
  sha512_arm64 = "e0802a394d043a56ec95dab56520aba933f271fc4d8098833b9f36e1943dc9897bb727bac503c0c6e46fa9b5db446c804be27209421896461acc6c848d9d6c3a"
  url_x64 = "https://download.visualstudio.microsoft.com/download/pr/d22c5e44-5ddc-41c2-bc23-cc7cbf7bed72/25e24c6de0c41648965533073cfba2c2/dotnet-sdk-#{version.csv.first}-osx-x64.pkg"
  url_arm64 = "https://download.visualstudio.microsoft.com/download/pr/9bb7054e-4547-4021-b46f-edee2428b10d/1dbe4945aabec0cd9c8b15080ec98b37/dotnet-sdk-#{version.csv.first}-osx-arm64.pkg"

  on_intel do
    sha512 sha512_x64
    url url_x64
  end
  on_arm do
    sha512 sha512_arm64
    url url_arm64
  end

  name ".NET Core SDK #{version.csv.first}"
  desc "This cask follows releases from https://github.com/dotnet/core/tree/master"
  homepage "https://www.microsoft.com/net/core#macos"

  livecheck do
    skip "See https://github.com/isen-ng/homebrew-dotnet-sdk-versions/blob/master/CONTRIBUTING.md#automatic-updates"
  end

  depends_on macos: ">= :mojave"

  pkg "dotnet-sdk-#{version.csv.first}-osx-#{arch}.pkg"

  uninstall pkgutil: "com.microsoft.dotnet.dev.#{version.csv.first}.component.osx.#{arch}"

  zap trash:   ["~/.dotnet", "~/.nuget", "/etc/paths.d/dotnet", "/etc/paths.d/dotnet-cli-tools"],
      pkgutil: [
        "com.microsoft.dotnet.hostfxr.#{version.csv.second}.component.osx.#{arch}",
        "com.microsoft.dotnet.sharedframework.Microsoft.NETCore.App.#{version.csv.second}.component.osx.#{arch}",
        "com.microsoft.dotnet.pack.apphost.#{version.csv.second}.component.osx.#{arch}",
        "com.microsoft.dotnet.sharedhost.component.osx.#{arch}",
      ]

  caveats "Uninstalling the offical dotnet-sdk casks will remove the shared runtime dependencies, " \
          "so you'll need to reinstall the particular version cask you want from this tap again " \
          "for the `dotnet` command to work again."
end
