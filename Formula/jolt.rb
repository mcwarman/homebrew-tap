class Jolt < Formula
  desc "JSON to JSON transformation library CLI"
  homepage "https://github.com/bazaarvoice/jolt/blob/master/cli/README.md"
  url "https://github.com/mcwarman/jolt-cli/releases/download/v0.1.5/jolt-cli.tar.gz"
  sha256 "d55d34f76c35bec77c6ba8878656f9b1cfbd75193e1d28d1922f8ea12c32828f"

  bottle do
    root_url "https://github.com/mcwarman/homebrew-tap/releases/download/jolt-0.1.5"
    rebuild 1
    sha256 cellar: :any_skip_relocation, big_sur:      "f3d536b429b37ea1e9089d1a884e1a0e046f201f05b92862f31ad22dae2bf405"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7b85bc7f95799f70176fd22f39228cb960a32cc95c42c2bc96ccea9abf987712"
  end

  depends_on "openjdk"

  def install
    libexec.install Dir["*"]
    (bin/"jolt").write_env_script libexec/"jolt", JAVA_HOME: Formula["openjdk"].opt_prefix
  end

  test do
    (testpath/"transform.json").write <<~EOS
      [
        {
          "operation": "shift",
          "spec": {
            "homebrew_version": "version"
          }
        }
      ]
    EOS
    assert_match "{\"version\":\"1.1.6\"}",
      shell_output("#{bin}/jolt transform -u transform.json #{test_fixtures("receipt.json")}")
  end
end
