class Drep < Formula
  desc "A local commit gate: runs the linters your repo configures, and sends changed code to an LLM for review"
  homepage "https://github.com/slb350/drep"
  version "3.1.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v3.1.8/drep-ai-aarch64-apple-darwin.tar.xz"
      sha256 "4527a4b84c5cfca75e63a5185759c37e8874cc5171b50698d39f2abe4f987158"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v3.1.8/drep-ai-x86_64-apple-darwin.tar.xz"
      sha256 "6b4b91fcc0d7f1b97a0aa2eb09ebbb15b7bc53ee3c77366f8cd836fb1246d08b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v3.1.8/drep-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e10ca263b21ab9aadc4dfc22ec2eaed08ba0b232a51981ec00c25f018de7fe92"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v3.1.8/drep-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9a56ccfdc44d9173d65e84b3cc7c8a5ba89b3116384102981d8c356223867d56"
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
