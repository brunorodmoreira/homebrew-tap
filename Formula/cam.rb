class Cam < Formula
  desc "Pick the Claude Code account per folder via .claude-account files"
  homepage "https://github.com/brunorodmoreira/cam"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/brunorodmoreira/cam/releases/download/v0.1.0/cam-cli-aarch64-apple-darwin.tar.xz"
      sha256 "4a845c3f2c2efbb17c349a937862ce1aa47b78f7279968b645a5ef5567219f11"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brunorodmoreira/cam/releases/download/v0.1.0/cam-cli-x86_64-apple-darwin.tar.xz"
      sha256 "5489f08fad4b22a25dfab87afc4611033bf9660bcf661efe7bd2d5742aae5010"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/brunorodmoreira/cam/releases/download/v0.1.0/cam-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "19c678a013c201949f21a5655d6330b73818c25d0335503f3fd91686b112c5b7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brunorodmoreira/cam/releases/download/v0.1.0/cam-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0d3b37f5dc02b248b220d818363b0c526463795d4da57097c6e9d8f8809e4827"
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
