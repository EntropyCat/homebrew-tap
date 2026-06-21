class Entropycat < Formula
  desc "Real-time data quality agent for Kafka streams"
  homepage "https://entropycat.io"
  version "0.1.14"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://github.com/EntropyCat/entropycat/releases/download/v#{version}/entropycat_#{version}_darwin_arm64.zip"
      sha256 "759e80af585917cc323b478b84330ef1537767842df0f4d9f14fcb5eace0ce8b"
    end
  end

  def install
    bin.install "entropycat"
    (share/"entropycat").install "THIRD_PARTY_LICENSES.txt"
  end

  # No post_install: the binary owns its config lifecycle. On first run it
  # creates ~/.entropycat/config.yaml from a bundled template, running in the
  # user's normal context rather than Homebrew's sandbox (which forbids writing
  # to the home directory). This keeps the formula simple and works identically
  # for the zip-download install path.

  def caveats
    <<~EOS
      On first run, entropycat creates a config file at:
        ~/.entropycat/config.yaml

      Edit it with your Kafka brokers, Slack token and other settings,
      then run `entropycat` again.
    EOS
  end

  service do
    run opt_bin/"entropycat"
    keep_alive true
    log_path var/"log/entropycat.log"
    error_log_path var/"log/entropycat.log"
    working_dir var
    environment_variables LANG: "en_US.UTF-8", LC_ALL: "en_US.UTF-8"
  end

  test do
    system "#{bin}/entropycat", "--help"
  end
end
