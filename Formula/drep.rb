class Drep < Formula
  desc "Local commit gate for repository linters and LLM code review"
  homepage "https://github.com/slb350/drep"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v3.1.0/drep-ai-aarch64-apple-darwin.tar.xz"
      sha256 "01e4ef25c91c626155863d229305c57c538e2636f7aba5d6874ddbbda4d379e4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v3.1.0/drep-ai-x86_64-apple-darwin.tar.xz"
      sha256 "26d4a025454a5999164a89b601f9f3d7ee3eca37f93ee34680b9bac69779cf9d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v3.1.0/drep-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "abd16407bcfd8c10f92ed498eec85fc44cfc8ce207f6b6c2c913a505a5357351"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v3.1.0/drep-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3a43e6b4083e5404d8a2d76cbc1359a980459981feb4739a54995c13bfc498f5"
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
