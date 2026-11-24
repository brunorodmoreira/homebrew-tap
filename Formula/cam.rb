class Cam < Formula
  desc "Pick the Claude Code account per folder via .claude-account files"
  homepage "https://github.com/brunorodmoreira/cam"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/brunorodmoreira/cam/releases/download/v0.1.4/cam-cli-aarch64-apple-darwin.tar.xz"
      sha256 "77ff8bc920ffff701afd06b168d64f7b63dc0181a6fec4199ab9f358f4f7865c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brunorodmoreira/cam/releases/download/v0.1.4/cam-cli-x86_64-apple-darwin.tar.xz"
      sha256 "2b924967b5ebbaa90a767fedc871f6dda66dbdd1af37a3c5aee8654c64de85ea"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/brunorodmoreira/cam/releases/download/v0.1.4/cam-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5a81572c2ee0c2e27da32274d5409c3455fa9806343edb234c36caf24c530cf1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brunorodmoreira/cam/releases/download/v0.1.4/cam-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7cbe09f7bc0b40b30322537f627b73ef21a276f8e7e75e72d55a7c5b66a4ae4f"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
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
      bin.install "cam"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cam"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cam"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cam"
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
