class Cacheexec < Formula
  desc "Shell-oriented caching tool, good for complex shell prompt decoration"
  homepage "https://github.com/jsleeio/cacheexec"
  url "https://github.com/jsleeio/cacheexec.git",
      :using    => :git,
      :tag      => "v1.0.0",
      :revision => "8f4f6e954a55f1fdc879c6f4c7f4108e425b912f"
  head "https://github.com/jsleeio/cacheexec.git"
  bottle :disable, "local build only"

  depends_on "go" => :build

  def install
    ENV["XC_OS"] = "darwin"
    ENV["XC_ARCH"] = "amd64"
    ENV["GOPATH"] = buildpath
    contents = Dir["{*,.git,.gitignore}"]
    (buildpath/"src/github.com/jsleeio/cacheexec").install contents

    (buildpath/"bin").mkpath

    cd "src/github.com/jsleeio/cacheexec" do
      system "go", "build"
      bin.install "cacheexec"
      prefix.install_metafiles
    end
  end

  test do
    system bin/"cacheexec", "--help"
  end
end
