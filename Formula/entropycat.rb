class Entropycat < Formula
  desc "Real-time data quality agent for Kafka streams"
  homepage "https://entropycat.io"
  version "0.2.3"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://github.com/EntropyCat/entropycat/releases/download/v#{version}/entropycat_#{version}_darwin_arm64.zip"
      sha256 "b4fa40805b83c40be78f57069f27cb358757d5fef934f213b4dff9a63c306b9e"
    end
  end

  def install
    bin.install "entropycat"
    bin.install "entropycatd"
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
