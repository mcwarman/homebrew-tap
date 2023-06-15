class Jolt < Formula
  desc "JSON to JSON transformation library CLI"
  homepage "https://github.com/bazaarvoice/jolt/blob/master/cli/README.md"
  url "https://github.com/mcwarman/jolt-cli/releases/download/v0.1.7/jolt-cli.tar.gz"
  version "0.1.7"
  sha256 "fcb691abc406e2c61ddf42f3ff3d9184a1cfeba7517af35057b45f419d40877b"

  bottle do
    root_url "https://github.com/mcwarman/homebrew-tap/releases/download/jolt-0.1.5"
    rebuild 2
    sha256 cellar: :any_skip_relocation, big_sur:      "a7ebbc7dd49c69ca981cd95b75a13f36031142b955f9abe2c2d7802993065f79"
    sha256 cellar: :any_skip_relocation, catalina:     "087e1294125d49868d158809dbce579e3ece6f15ca8291afa71698ddb5ab48bd"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9e00aba91fd8b26fd4aafb8fd9267f1065ddcc20c7b013745dc34cd0eb8f150b"
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
