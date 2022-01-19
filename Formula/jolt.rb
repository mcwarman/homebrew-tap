class Jolt < Formula
  desc "JSON to JSON transformation library CLI"
  homepage "https://github.com/bazaarvoice/jolt/blob/master/cli/README.md"
  url "https://github.com/mcwarman/jolt-cli/releases/download/v0.1.5/jolt-cli.tar.gz"
  sha256 "398ee3d8daec6f8bb496cea4c9aee2eb70fcbf7c8bb183e301ffc0ee56b96a8d"

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
