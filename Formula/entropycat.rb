class Entropycat < Formula
  desc "Real-time data quality agent for Kafka streams"
  homepage "https://entropycat.io"
  version "0.2.9"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://github.com/EntropyCat/entropycat/releases/download/v#{version}/entropycat_#{version}_darwin_arm64.zip"
      sha256 "396f23ea06ec66afd3b1a241fa024e249bd8c0c4e97c2678b4738a88bc295e1e"
    end
    on_intel do
      url "https://github.com/EntropyCat/entropycat/releases/download/v#{version}/entropycat_#{version}_darwin_x86_64.zip"
      sha256 "54f62af2425a4e80ec5331f13a0aff106365c57f377f1b036613be171a773536"
    end
  end

  def install
    bin.install "entropycat"
    (share/"entropycat").install "THIRD_PARTY_LICENSES.txt"
  end

  def caveats
    <<~EOS
      Run `entropycat` to complete setup. You will be prompted for your
      Kafka brokers and Slack bot token. 
    EOS
  end

  test do
    system "#{bin}/entropycat", "--help"
  end
end
