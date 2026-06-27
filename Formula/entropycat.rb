class Entropycat < Formula
  desc "Real-time data quality agent for Kafka streams"
  homepage "https://entropycat.io"
  version "0.2.14"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://github.com/EntropyCat/entropycat/releases/download/v#{version}/entropycat_#{version}_darwin_arm64.zip"
      sha256 "370909bb57107f83f6a7c63f21501decda366c38c6e5fcd9e9dfda708983a13c"
    end
    on_intel do
      url "https://github.com/EntropyCat/entropycat/releases/download/v#{version}/entropycat_#{version}_darwin_x86_64.zip"
      sha256 "135e22075d014eb67f57c4b6fea5e3226f4b531b1b9b7287fd06b0e7ad782fcc"
    end
  end

  def install
    # standalone Nuitka build: a folder of the launcher + its dylibs/data.
    # Install the whole thing into libexec and symlink just the launcher onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"entropycat"
  end

  def caveats
    <<~EOS
      Run `entropycat init` to complete setup. You will be prompted for your
      Kafka brokers and Slack bot token. 
    EOS
  end

  test do
    system "#{bin}/entropycat", "--help"
  end
end
