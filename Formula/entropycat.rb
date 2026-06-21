class Entropycat < Formula
  desc "Real-time data quality agent for Kafka streams"
  homepage "https://entropycat.io"
  version "0.2.4"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://github.com/EntropyCat/entropycat/releases/download/v#{version}/entropycat_#{version}_darwin_arm64.zip"
      sha256 "b5a3d4ddaf2f939d4c5069f013dd8e0f3d1f4035c23f2edb2c059a972dc566da"
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
