class Drep < Formula
  desc "A local commit gate: runs the linters your repo configures, and sends changed code to an LLM for review"
  homepage "https://github.com/slb350/drep"
  version "3.1.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v3.1.7/drep-ai-aarch64-apple-darwin.tar.xz"
      sha256 "11c343a28150e705fded5b1ccd8adbdbfc277216f7c89f01a848b567194468c8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v3.1.7/drep-ai-x86_64-apple-darwin.tar.xz"
      sha256 "f21c82c88ed75b71b9954e680ed0fc70260586d368d3465377dbfd2856b3ef8e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v3.1.7/drep-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bcaa2d94b650dd67807ac3027aeb1bb69c98eb333e04ccf92a160b4c55702678"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v3.1.7/drep-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "862698f6f0fae7042e88ab74ce55cbbdbe7a23d4f9fb042f6a9b9bd156b74401"
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
