class Drep < Formula
  desc "A local commit gate: runs the linters your repo configures, and sends changed code to an LLM for review"
  homepage "https://github.com/slb350/drep"
  version "2.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.4.0/drep-ai-aarch64-apple-darwin.tar.xz"
      sha256 "955b43c346dc60cf4c6c6d9660180a64839e58e71452a709daa6255241ab81aa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.4.0/drep-ai-x86_64-apple-darwin.tar.xz"
      sha256 "37fb3ba66e0b1395374689efa314f04eefe0466b54b6c94271c121cee523c285"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/slb350/drep/releases/download/v2.4.0/drep-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b618fa7f6bc434144c490adbd8bb394c4bac1816ef51df3f522146786aeeecb4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/slb350/drep/releases/download/v2.4.0/drep-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5ed9c794d602c778eb656e414a7a5343ea807b5788435c1a3230effc2e66f075"
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
