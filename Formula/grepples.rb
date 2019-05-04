class GoEagle < Formula
  desc "Aggressively-parallelized grep utility for AWS S3"
  homepage "https://github.com/jsleeio/grepples"
  url "https://github.com/jsleeio/grepples.git",
      :using    => :git,
      :tag      => "v0.1.2",
      :revision => "ec3d3d474c7ad0581e56fcfd6ff207d008c6b061"
  head "https://github.com/jsleeio/grepples.git"
  bottle :disable, "local build only"

  depends_on "go" => :build

  def install
    ENV["XC_OS"] = "darwin"
    ENV["XC_ARCH"] = "amd64"
    ENV["GOPATH"] = buildpath
    contents = Dir["{*,.git,.gitignore}"]
    (buildpath/"src/github.com/jsleeio/grepples").install contents

    (buildpath/"bin").mkpath

    cd "src/github.com/jsleeio/grepples" do
      system "make"
      bin.install "grepples"
      prefix.install_metafiles
    end
  end

  test do
    system bin/"grepples", "--help"
  end
end
