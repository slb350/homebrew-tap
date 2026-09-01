class Drep < Formula
  desc "Local commit gate for repository linters and LLM code review"
  homepage "https://github.com/slb350/drep"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.8.0/drep-ai-aarch64-apple-darwin.tar.xz"
      sha256 "7cbfb1f5c36692ecbefb20d0575ac0f6d2152bd0295a2c4b29dcbc6cda1493b6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.8.0/drep-ai-x86_64-apple-darwin.tar.xz"
      sha256 "cf426cb2773b4345799bb5e11f23b6b417af5f508d116d416e74bbe25bbd4972"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.8.0/drep-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "016204babb4b0774054747b59bcd8c2f756f17ee44d501a35721afdeddce81c0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.8.0/drep-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4c8d58062443539e66392b0589eec1f4784f0e24d1666b0c9f78d26b95f533cd"
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
