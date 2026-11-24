class Cam < Formula
  desc "Pick the Claude Code account per folder via .claude-account files"
  homepage "https://github.com/brunorodmoreira/cam"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/brunorodmoreira/cam/releases/download/v0.1.2/cam-cli-aarch64-apple-darwin.tar.xz"
      sha256 "d2ea8354fd2c8affa7c9ba93f5d88f6d5bfa694161a189ca4f438e2da45e3e13"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brunorodmoreira/cam/releases/download/v0.1.2/cam-cli-x86_64-apple-darwin.tar.xz"
      sha256 "7765c7e91d7b38e152463bf654b481dcbe95ed1d5c4d03bff36ee9c72d08e5ea"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/brunorodmoreira/cam/releases/download/v0.1.2/cam-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "100fa28e48a9d1e895e2a2fa26637d35d7a3a749dba09cd85ac0a5324c7ba6e6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brunorodmoreira/cam/releases/download/v0.1.2/cam-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2add47deeb0b6c0491cdc1b6343e2a0414c668825420320fb6e365ea4073882e"
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
