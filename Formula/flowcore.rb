class GitHubPrivateReleaseDownloadStrategy < CurlDownloadStrategy
  def _fetch(url:, resolved_url:, timeout:)
    token = ENV.fetch("HOMEBREW_GITHUB_API_TOKEN") {
      raise "Set HOMEBREW_GITHUB_API_TOKEN to install from a private repo"
    }
    curl_download(
      url,
      "--header", "Authorization: token #{token}",
      "--header", "Accept: application/octet-stream",
      to: temporary_path,
      timeout: timeout,
    )
  end
end

class Flowcore < Formula
  desc "Flowcore Water Operations CLI — unified interface for all Flowcore services"
  homepage "https://github.com/Flowcore-Water/flowcore-mcp"
  url "https://api.github.com/repos/Flowcore-Water/flowcore-mcp/releases/assets/420442013",
      using: GitHubPrivateReleaseDownloadStrategy
  version "1.0.1"
  sha256 "06b28fa3248c83920234d441d2fb0d5f53560cf92efc23e369ed2d1e479c10b1"
  license "MIT"

  depends_on "node@20"

  def install
    system "npm", "ci"
    system "npm", "run", "build"

    # Install the built CLI — preserve directory structure
    libexec.install "dist"
    libexec.install "node_modules"
    libexec.install "package.json"

    # Create wrapper script
    (bin/"flowcore").write <<~EOS
      #!/bin/bash
      exec "#{Formula["node@20"].opt_bin}/node" "#{libexec}/dist/cli/index.js" "$@"
    EOS

    # Create MCP server wrapper
    (bin/"flowcore-mcp").write <<~EOS
      #!/bin/bash
      exec "#{Formula["node@20"].opt_bin}/node" "#{libexec}/dist/index.js" "$@"
    EOS
  end

  test do
    assert_match "Flowcore Water Operations CLI", shell_output("#{bin}/flowcore --help")
    assert_match "wellscope", shell_output("#{bin}/flowcore --help")
  end
end
