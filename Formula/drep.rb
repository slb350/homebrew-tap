class Drep < Formula
  desc "A local commit gate: runs the linters your repo configures, and sends changed code to an LLM for review"
  homepage "https://github.com/slb350/drep"
  version "2.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.2.0/drep-ai-aarch64-apple-darwin.tar.xz"
      sha256 "648967f39ff83503293b238a11e00f1fa0649f4f80cbd088dcac02ba3cc48a66"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.2.0/drep-ai-x86_64-apple-darwin.tar.xz"
      sha256 "44f1fea93df881b0979966e84e86e96b05fdab1cb740490bf738d732c0967c42"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.2.0/drep-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2119a16b7c7f4261e61e073d4705022cb36fc791b080f813a9e5a057e2544808"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.2.0/drep-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "98b2cd587bca3a87a42dcb15b05b7d460c34d54990bd633d462031f4bcee1452"
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
end
