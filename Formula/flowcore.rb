class Flowcore < Formula
  desc "Flowcore Water Operations CLI — unified interface for all Flowcore services"
  homepage "https://github.com/Flowcore-Water/flowcore-mcp"
  url "https://github.com/Flowcore-Water/flowcore-mcp.git",
      tag: "v1.0.0",
      revision: "HEAD"
  license "MIT"

  depends_on "node@20"

  def install
    system "npm", "ci"
    system "npm", "run", "build"

    # Install the built CLI
    libexec.install Dir["dist/**/*"]
    libexec.install "node_modules"
    libexec.install "package.json"

    # Create wrapper script
    (bin/"flowcore").write <<~EOS
      #!/bin/bash
      exec "#{Formula["node@20"].opt_bin}/node" "#{libexec}/cli/index.js" "$@"
    EOS

    # Create MCP server wrapper
    (bin/"flowcore-mcp").write <<~EOS
      #!/bin/bash
      exec "#{Formula["node@20"].opt_bin}/node" "#{libexec}/index.js" "$@"
    EOS
  end

  test do
    assert_match "Flowcore Water Operations CLI", shell_output("#{bin}/flowcore --help")
    assert_match "wellscope", shell_output("#{bin}/flowcore --help")
  end
end
