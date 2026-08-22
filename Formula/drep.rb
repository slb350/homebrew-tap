class Drep < Formula
  desc "A local commit gate: runs the linters your repo configures, and sends changed code to an LLM for review"
  homepage "https://github.com/slb350/drep"
  version "2.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.5.1/drep-ai-aarch64-apple-darwin.tar.xz"
      sha256 "6a067a5c8df06d24c2235bcc4ffc97d068a4022e90c33065eabe883079b3d6b0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.5.1/drep-ai-x86_64-apple-darwin.tar.xz"
      sha256 "ae3cc16d771ba4d947dc92d496b6121c137e4c7f31e0f0142501d67b16dbbbdd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.5.1/drep-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a53c99c7af660174ff64c6ad087937172b84bfa6c4f11e8df63260d4ae125177"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.5.1/drep-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e1d56548633b65d18be6bf351b465cd610fc328ae7c811c786f5075b6d4d0a24"
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
