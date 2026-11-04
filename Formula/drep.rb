class Drep < Formula
  desc "A local commit gate: runs the linters your repo configures, and sends changed code to an LLM for review"
  homepage "https://github.com/slb350/drep"
  version "3.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v3.1.5/drep-ai-aarch64-apple-darwin.tar.xz"
      sha256 "165e0b0f8b9ebe7bb8bbb1fd33b9088f0f047db285b011c126570568de3e7557"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v3.1.5/drep-ai-x86_64-apple-darwin.tar.xz"
      sha256 "4a6069fcba8e6f19078840e14e1c5f3096be0e87e23360e2497ed93e6dcb0f0b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v3.1.5/drep-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9e7b88668babcd541d6a763e79dbcdcae1ffdb0cd5a81738d8aa30778ea811f0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v3.1.5/drep-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1f867fc90f2d516419ed4481c34445eb400d395874f3a54b58aca632e469dca8"
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
