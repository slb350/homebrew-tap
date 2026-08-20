class Drep < Formula
  desc "A local commit gate: runs the linters your repo configures, and sends changed code to an LLM for review"
  homepage "https://github.com/slb350/drep"
  version "2.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.1.0/drep-ai-aarch64-apple-darwin.tar.xz"
      sha256 "2fc1fc17f5da2bbef40dce38ac743a5174fd4c1066fa3f6076c44334ba44eac6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.1.0/drep-ai-x86_64-apple-darwin.tar.xz"
      sha256 "e23bc86cb6b0e25516aca6e8d046ae1f1503f33d288094949bb75c7cd6d22075"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.1.0/drep-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "59659c0c9d056022f059accb2595ae85ef5440bb47ebea62c129789ab61426f1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.1.0/drep-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e10ee42af7086c2be05f80517400e1ebad24cf51afbf92db331209c8236ccd32"
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
