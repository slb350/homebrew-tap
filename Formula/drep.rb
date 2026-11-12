class Drep < Formula
  desc "A local commit gate: runs the linters your repo configures, and sends changed code to an LLM for review"
  homepage "https://github.com/slb350/drep"
  version "3.1.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v3.1.6/drep-ai-aarch64-apple-darwin.tar.xz"
      sha256 "33c90fca8969cac258aeac3a99aed206d5148a1b3297e5a0ac7c5e4ea881b697"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v3.1.6/drep-ai-x86_64-apple-darwin.tar.xz"
      sha256 "9280aca327d8676235fd15c77a16987c4d73f9aa45ac2a90ac7ec87a08b9bb38"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v3.1.6/drep-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e428ffa7b982e6ae16d0502668b048cf323d2bb6fcd37cf90430505e28c05dc0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v3.1.6/drep-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7f72e6faabff5c4887a5f786b0b65ca2b843e9c66f9b4b6630da3ea1a554dd85"
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
