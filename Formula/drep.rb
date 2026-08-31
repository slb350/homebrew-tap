class Drep < Formula
  desc "A local commit gate: runs the linters your repo configures, and sends changed code to an LLM for review"
  homepage "https://github.com/slb350/drep"
  version "2.7.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.7.2/drep-ai-aarch64-apple-darwin.tar.xz"
      sha256 "63dbfc769d1cd89a40ae4ff725f336181c4a9b75d1324196513cd90b8c3b0c0e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.7.2/drep-ai-x86_64-apple-darwin.tar.xz"
      sha256 "5116ebd0689f4c7a8833c366114756237f605dd23ecf62b8cc983c652bfc8ac4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.7.2/drep-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2850b54bbac1576a65b348acb8d0caaac72d9bc7139da9d9281a4d1a51ec7f6e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.7.2/drep-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7ca898abfc5adfd6313cd985af5c222855096110cd6b556775751ad4d87b6205"
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
