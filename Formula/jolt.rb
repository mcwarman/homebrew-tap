class Jolt < Formula
  desc "JSON to JSON transformation library CLI"
  homepage "https://github.com/bazaarvoice/jolt/blob/master/cli/README.md"
  url "https://github.com/mcwarman/jolt-cli/releases/download/v0.1.8/jolt-cli.tar.gz"
  sha256 "b5ad1a925216bc35991b2b2e008b25fb196dd7ce583ac16731736127dd0e5374"

  bottle do
    root_url "https://github.com/mcwarman/homebrew-tap/releases/download/jolt-0.1.7"
    sha256 cellar: :any_skip_relocation, monterey:     "f8f5572d6cccf20e6205e2468c31356bd3464a8d2f165db5b9cb081acb9fbe61"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "629a71ba4548c9d9c18ef5368a252bfee68d96ec42f074bdcb6e20f68a856546"
  end

  depends_on "openjdk"

  def install
    libexec.install Dir["*"]
    (bin/"jolt").write_env_script libexec/"jolt", JAVA_HOME: Formula["openjdk"].opt_prefix
  end

  test do
    (testpath/"shift.json").write <<~EOS
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
      shell_output("#{bin}/jolt transform -u shift.json #{test_fixtures("receipt.json")}")
  end
end
