class Cam < Formula
  desc "Pick the Claude Code account per folder via .claude-account files"
  homepage "https://github.com/brunorodmoreira/cam"
  version "0.1.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/brunorodmoreira/cam/releases/download/v0.1.6/cam-cli-aarch64-apple-darwin.tar.xz"
      sha256 "679ba4e9c858b130f9716f2037ac915b864b3da2db5d709fb4c5a421d99f0c87"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brunorodmoreira/cam/releases/download/v0.1.6/cam-cli-x86_64-apple-darwin.tar.xz"
      sha256 "d436c5e358e7edc514746bff7aaf75c89b4c127fd8287e30df10619d01e47c31"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/brunorodmoreira/cam/releases/download/v0.1.6/cam-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bb5e8cd6043c0166c9160ecc1bb53b17c9231595d648c5f389111083db67ebaa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brunorodmoreira/cam/releases/download/v0.1.6/cam-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fd1c7cbb985e0c7c602c470132a2c0e10a98973d43655e0b99875b382fe8aaa1"
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
