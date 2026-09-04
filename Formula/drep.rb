class Drep < Formula
  desc "A local commit gate: runs the linters your repo configures, and sends changed code to an LLM for review"
  homepage "https://github.com/slb350/drep"
  version "3.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v3.0.0/drep-ai-aarch64-apple-darwin.tar.xz"
      sha256 "3d2b659f1c1bd957597b108eabba6e86e6cec3ae3b7fcdba30bbe8c1d2688e1b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v3.0.0/drep-ai-x86_64-apple-darwin.tar.xz"
      sha256 "e037c9a892428b510e19f42abd728f8ca1eddb2f8d5321eca71ff58761042226"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v3.0.0/drep-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "345b6bad5d5474794f82107efdd4fcb3ab26b58349d7cd219b30d5d1f2625e6b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v3.0.0/drep-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "112ec2409a6e4fd76f69edd2e4365ea4282052ac704198e83c2522ddfc3af4ab"
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
