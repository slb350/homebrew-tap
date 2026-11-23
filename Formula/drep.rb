class Drep < Formula
  desc "Local commit gate with configured linters and LLM code review"
  homepage "https://github.com/slb350/drep"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v3.1.9/drep-ai-aarch64-apple-darwin.tar.xz"
      sha256 "c72b8d54ab07282d0cb19c75606e9fe3c0a90b9b7e4a7f63b9934b7da1f74505"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v3.1.9/drep-ai-x86_64-apple-darwin.tar.xz"
      sha256 "bb8acb1328efc3cd8d5438733f7035d47aa80046b56738627c5bc31aa0d9453f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v3.1.9/drep-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "858eec1694556699da9cc9c4af420b4830db758141ce73240cecfad923ce4f2c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v3.1.9/drep-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bf7dd7f5b26b680e6873f22d83aff24d2012caff86a3ebeb431fe2c2fa9c7cdd"
    end
  end
  license "MIT"

  def install
    bin.install "drep"

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end

  test do
    assert_equal "drep #{version}", shell_output("#{bin}/drep --version").strip
  end
end
