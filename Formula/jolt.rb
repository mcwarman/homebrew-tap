class Jolt < Formula
  desc "JSON to JSON transformation library CLI"
  homepage "https://github.com/bazaarvoice/jolt/blob/master/cli/README.md"
  url "https://github.com/mcwarman/jolt-cli/releases/download/v0.1.5/jolt-cli.tar.gz"
  sha256 "d55d34f76c35bec77c6ba8878656f9b1cfbd75193e1d28d1922f8ea12c32828f"

  def install
    chmod 0755, "jolt"
    libexec.install Dir["*"]
    bin.install_symlink Dir["#{libexec}/jolt"]
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
