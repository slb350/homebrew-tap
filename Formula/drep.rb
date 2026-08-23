class Drep < Formula
  desc "A local commit gate: runs the linters your repo configures, and sends changed code to an LLM for review"
  homepage "https://github.com/slb350/drep"
  version "2.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.6.0/drep-ai-aarch64-apple-darwin.tar.xz"
      sha256 "ff8c17647b0d1d827893e402b8121b85bd93023def0b8cb0137b1b77120e767f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.6.0/drep-ai-x86_64-apple-darwin.tar.xz"
      sha256 "bd3847a2e6625c0552f50157d62eea8b50008eb7f364988a850997b400e3e6ec"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.6.0/drep-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cd98a1fe1190f781eb776d164b1a0cb25c1d4a5d1d3f4ff136fa628de2685bb8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.6.0/drep-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2781d2447a584852ffffebdb339e07885a8fc4fc19acdcb099498b9ecc4bcea5"
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
