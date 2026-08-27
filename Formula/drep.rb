class Drep < Formula
  desc "A local commit gate: runs the linters your repo configures, and sends changed code to an LLM for review"
  homepage "https://github.com/slb350/drep"
  version "2.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.7.0/drep-ai-aarch64-apple-darwin.tar.xz"
      sha256 "8f1745111d2c019f5294993ed02da509fc799e9c5daae76ef53d62ac0e2d2841"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.7.0/drep-ai-x86_64-apple-darwin.tar.xz"
      sha256 "78305cfc8a47dba20ce603dda1bc8ab14f96815892cc358b902dde4026bef06d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.7.0/drep-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "95fed0cc0643701af204e22503b43063ac83d5b0fab7cebf9b7276d7082530c8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.7.0/drep-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "47fde09612de5f6240fd3a671922c67d9822c6451127e2fe7fa7f83f1056f52a"
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
