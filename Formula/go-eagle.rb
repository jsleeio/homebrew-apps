class GoEagle < Formula
  desc "CLI tools for creating and manipulating Autodesk Eagle CAD files"
  homepage "https://github.com/jsleeio/go-eagle"
  url "https://github.com/jsleeio/go-eagle.git",
      :using    => :git,
      :tag      => "v0.0.3",
      :revision => "9a829ec9fc24914ff4807ffe822af224951a5f69"
  head "https://github.com/jsleeio/go-eagle.git"
  bottle :disable, "local build only"

  depends_on "go" => :build

  def install
    # Avoid running `go get`
    # inreplace "GNUmakefile", "go get -u -v $(GOTOOLS)", ""

    ENV["XC_OS"] = "darwin"
    ENV["XC_ARCH"] = "amd64"
    ENV["GOPATH"] = buildpath
    contents = Dir["{*,.git,.gitignore}"]
    (buildpath/"src/github.com/jsleeio/go-eagle").install contents

    (buildpath/"bin").mkpath

    cd "src/github.com/jsleeio/go-eagle" do
      system "make clean binaries"
      bin.install "schroff"
      bin.install "panelgen"
      prefix.install_metafiles
    end
  end

  test do
    system bin/"schroff", "--help"
    system bin/"panelgen", "--help"
  end
end
