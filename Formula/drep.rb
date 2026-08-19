class Drep < Formula
  desc "A local commit gate: runs the linters your repo configures, and sends changed code to an LLM for review"
  homepage "https://github.com/slb350/drep"
  version "2.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.0.0/drep-ai-aarch64-apple-darwin.tar.xz"
      sha256 "1aea09e1bc64e1dfe1bec9913ba90e0786c3b76cbe8835542a41c071d751f6de"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.0.0/drep-ai-x86_64-apple-darwin.tar.xz"
      sha256 "0a9cf6ee17d92c157aa59da65164e101e4c5ffae711b0556b5dd2ba7ec01d4d7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.0.0/drep-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "455791fe8b11865cf16e993587bfc352ecbb4cb5a34d7a80b6b4fd130ac2183b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.0.0/drep-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "809b4a450abc476f0bb8f9068adb33f939c20b1f763ae72ad06ae46b0d2f5e9b"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
