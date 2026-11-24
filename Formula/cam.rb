class Cam < Formula
  desc "Pick the Claude Code account per folder via .claude-account files"
  homepage "https://github.com/brunorodmoreira/cam"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/brunorodmoreira/cam/releases/download/v0.1.1/cam-cli-aarch64-apple-darwin.tar.xz"
      sha256 "3fc476df30aca832608d34765517828b4a2aa47b3218d329ad327c65b4af4f3e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brunorodmoreira/cam/releases/download/v0.1.1/cam-cli-x86_64-apple-darwin.tar.xz"
      sha256 "54adec51347fffe62d9d05af150f65288f85bfd477fa6539e4e6e76d4c60982d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/brunorodmoreira/cam/releases/download/v0.1.1/cam-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "676a9dfad31f570262c533301d1ade187c1d937ba1ed3876d2c7c300c65ffa5a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brunorodmoreira/cam/releases/download/v0.1.1/cam-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8df15cd20dd975ad9bb8e7f9173d01cbc57419717a682e06dac041e24c00cd9e"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

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
