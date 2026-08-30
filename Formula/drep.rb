class Drep < Formula
  desc "A local commit gate: runs the linters your repo configures, and sends changed code to an LLM for review"
  homepage "https://github.com/slb350/drep"
  version "2.7.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.7.1/drep-ai-aarch64-apple-darwin.tar.xz"
      sha256 "00523ffdfd9e56252bc40c9e8458c03094706903a19fed808c70ace083236039"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.7.1/drep-ai-x86_64-apple-darwin.tar.xz"
      sha256 "7ec4f16a49805d6ee22df672899d80a95552e3823297063f86ce8e96c4d23a04"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.7.1/drep-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cb56bce672c2b5da7420c78e096463e7e263296391f41b0b11257f7c2765d814"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.7.1/drep-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b0902c5cc5439ec8883e806d1b6411058cb60abc68c7b80695bcd2048c1cb17a"
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
