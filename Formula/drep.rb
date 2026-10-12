class Drep < Formula
  desc "Local commit gate for repository linters and LLM code review"
  homepage "https://github.com/slb350/drep"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v3.1.2/drep-ai-aarch64-apple-darwin.tar.xz"
      sha256 "879c1d772e97527f9c5c56c250bbdd1517ac3d40688bb6232c5030d107689ac3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v3.1.2/drep-ai-x86_64-apple-darwin.tar.xz"
      sha256 "0dd52c99198a829b53c6036fd25dcd2d33b60cf8c3e11ae04308266f7e7a7e0d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v3.1.2/drep-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2a8a12db571d801813de73a1a4d0af47b14899af5bafb7181b9803ed6f168006"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v3.1.2/drep-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6015a723720f05148fe425d5694fbf29a51c0e87de71ae647ffe6ab4919a127a"
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

  test do
    assert_match version.to_s, shell_output("#{bin}/drep --version")
  end
end
