class GoEagle < Formula
  desc "CLI tools for creating and manipulating Autodesk Eagle CAD files"
  homepage "https://github.com/jsleeio/go-eagle"
  head "https://github.com/jsleeio/go-eagle.git",

  bottle do
    cellar :any_skip_relocation
    sha256 "" => :mojave
    sha256 "" => :high_sierra
    sha256 "" => :sierra
  end

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
      system "make"
      bin.install "schroff"
      bin.install "panelgen"
      prefix.install_metafiles
    end
  end
end
