class Entropycat < Formula
  desc "Real-time data quality agent for Kafka streams"
  homepage "https://entropycat.io"
  version "0.3.4"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://github.com/EntropyCat/entropycat/releases/download/v#{version}/entropycat_#{version}_darwin_arm64.zip"
      sha256 "9e780f78c89162a51ce9a80c829173bbdcce703e8dcecb8244dba8ba8f0ec6bd"
    end
    on_intel do
      url "https://github.com/EntropyCat/entropycat/releases/download/v#{version}/entropycat_#{version}_darwin_x86_64.zip"
      sha256 "6eab4e37bd87b923bc492f63c0d27193d40e3ce5efc11dcefbefbf7fc3c8f7e0"
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
