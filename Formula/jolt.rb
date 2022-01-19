class Jolt < Formula
  desc "JSON to JSON transformation library CLI"
  homepage "https://github.com/bazaarvoice/jolt/blob/master/cli/README.md"
  url "https://github.com/mcwarman/jolt-cli/releases/download/v1.0.0-beta.4/jolt-cli.tar.gz"
  sha256 "869dc6fb274b63a4bb99b893e2f534d5c4dfbd513d28330a52c7d31f32d09558"

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
