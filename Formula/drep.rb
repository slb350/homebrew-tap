class Drep < Formula
  desc "Local commit gate with configured linters and LLM code review"
  homepage "https://github.com/slb350/drep"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v3.1.10/drep-ai-aarch64-apple-darwin.tar.xz"
      sha256 "9da4f16e62f71e0c0b1d0e0b27886e3f25bdf36ac57afe280abf837a8d4fab05"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v3.1.10/drep-ai-x86_64-apple-darwin.tar.xz"
      sha256 "50cf056ce8728420f9d72792ce662654e38b977f55677bf9a160e93dbbd2d03b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v3.1.10/drep-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "abcbffb7287b1e08334795f508845f7f9518056d57e623131e246e17c5f7a93f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v3.1.10/drep-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9db39e3bef061694f430c7aecf59d0262506ebac36a959a8f76bd0c7f650b14f"
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
