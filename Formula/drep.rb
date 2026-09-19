class Drep < Formula
  desc "Local commit gate for repository linters and LLM code review"
  homepage "https://github.com/slb350/drep"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v3.1.1/drep-ai-aarch64-apple-darwin.tar.xz"
      sha256 "f9f148d0fdaa13b516b5c2bae4780ae429567998ec29212644b3e447907fae59"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v3.1.1/drep-ai-x86_64-apple-darwin.tar.xz"
      sha256 "9e1697e90e0d5176023a8ae022b7128e5a6122d6d1ed409c3f9c0af2fdf00147"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v3.1.1/drep-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2aa0e8b8a56f57dc76c1f5c37a06388a88fb1265c277da8a80fc942abeb09715"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v3.1.1/drep-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "387e558a16bf154745ad7852c1f6b2daf9e21aa794ea82d4c866c51d87e617e5"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "drep"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "drep"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "drep"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "drep"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/drep --version")
  end
end
