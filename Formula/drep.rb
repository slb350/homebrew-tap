class Drep < Formula
  desc "A local commit gate: runs the linters your repo configures, and sends changed code to an LLM for review"
  homepage "https://github.com/slb350/drep"
  version "2.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.6.1/drep-ai-aarch64-apple-darwin.tar.xz"
      sha256 "4edd1f56fa7abcf046e60029bcc2019666793a14c12fbe3b2bea6262faa0e5a7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.6.1/drep-ai-x86_64-apple-darwin.tar.xz"
      sha256 "17808e1be0c2b530f94c7f03ce7ebce27c6b548fe8b66297dcc1957fd2eecaf1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.6.1/drep-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9318ea893d150e70d30d0fb02f58365e474daba4cecd1e98bc2fa12eba0043fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.6.1/drep-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c9ce16b50e827559618f7c9d61dd9255433f809d9e1172beae2ad34e60a72815"
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
