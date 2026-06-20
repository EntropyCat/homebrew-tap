class Entropycat < Formula
  desc "Real-time data quality agent for Kafka streams"
  homepage "https://entropycat.io"
  version "0.1.1"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://github.com/EntropyCat/entropycat/releases/download/v#{version}/entropycat_#{version}_darwin_arm64.zip"
      sha256 "ab55f2c6c72467719163dcc7de2e8a8bfddc01f6c3e489dbcf49c7591485f24c"
    end
  end

  def install
    bin.install "entropycat"
    (share/"entropycat").install "config.yaml"
    (share/"entropycat").install "THIRD_PARTY_LICENSES.txt"
  end

  def post_install
    ohai "post_install running..."
    config_dir  = Pathname.new(Dir.home)/".entropycat"
    config_file = config_dir/"config.yaml"
    ohai "config_dir: #{config_dir}"
    ohai "config_file exists: #{config_file.exist?}"
    ohai "share path: #{share/"entropycat"/"config.yaml"}"
    unless config_file.exist?
      config_dir.mkpath
      config_file.write((share/"entropycat"/"config.yaml").read)
      ohai "config file created at #{config_file}"
    end
  end

  def caveats
    <<~EOS
      Config file: ~/.entropycat/config.yaml
      Edit it to configure your Kafka brokers and other settings, then run:
        entropycat --config ~/.entropycat/config.yaml
    EOS
  end

  test do
    system "#{bin}/entropycat", "--help"
  end
end
