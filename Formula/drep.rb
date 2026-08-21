class Drep < Formula
  desc "A local commit gate: runs the linters your repo configures, and sends changed code to an LLM for review"
  homepage "https://github.com/slb350/drep"
  version "2.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.5.0/drep-ai-aarch64-apple-darwin.tar.xz"
      sha256 "88658d85809b13fa85a7784de724763f21fe6bc9125837fb8fc032f1bf515c91"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.5.0/drep-ai-x86_64-apple-darwin.tar.xz"
      sha256 "c80d1fd2d7f7ea9a574abb24c633aec1b265ba81d28fc9bc73d39cbff4aec74c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.5.0/drep-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "826a036320495a4dcc5a443e0ef2e45a45c73d6067519feb579fdf5bff9dfa3c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.5.0/drep-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "455a891aed51cb1e418d74e786030d75f17a44430072feec149b00cbc893107b"
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
