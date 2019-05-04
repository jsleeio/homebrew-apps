class Cloudtools < Formula
  desc "A collection of cloud-oriented tooling curated by @jsleeio"
  homepage "https://github.com/jsleeio"
  depends_on "jq"
  depends_on "kops"
  depends_on "kubernetes-cli"
  depends_on "kubernetes-helm"
  depends_on "terraform"
  depends_on "stern"
  depends_on "watch"

  test do
    system bin/"jq", "-V"
    system bin/"kops", "version"
    system bin/"helm", "version"
    system bin/"kubectl", "version"
    system bin/"terraform", "version"
    system bin/"stern", "-v"
    system bin/"watch", "-v"
  end
end
