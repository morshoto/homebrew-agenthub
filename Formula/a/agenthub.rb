class Agenthub < Formula
  desc "CLI for provisioning and operating AgentHub environments"
  homepage "https://github.com/morshoto/agenthub"
  url "https://github.com/morshoto/agenthub/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "686e2de8a4b1c3c843ec8b1468245304ee4668abfd15b83d4ca68d5a73bdc6e7"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s
      -w
      -X agenthub/internal/app.Version=v#{version}
      -X agenthub/internal/app.CommitSHA=unknown
      -X agenthub/internal/app.BuildDate=unknown
    ].join(" ")

    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/agenthub"
  end

  test do
    output = shell_output("#{bin}/agenthub version")
    assert_match "agenthub v#{version}", output
    assert_match "commit: unknown", output
    assert_match "build date: unknown", output
  end
end
