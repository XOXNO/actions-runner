# XOXNO Actions runner

GitHub Actions runner image with native build tools for XOXNO Rust CI.
Based on the official runner image; preserves its runner user and startup layout.

Every push to `main` builds and smoke-tests a Linux AMD64 image on GitHub-hosted
Ubuntu, then publishes to GHCR using the repository's built-in `GITHUB_TOKEN`:

- `ghcr.io/xoxno/actions-runner:latest`
- `ghcr.io/xoxno/actions-runner:sha-<full-commit-sha>`

Pull requests build and test without publishing. Manual runs publish only from
`main`. No registry password or personal access token is needed for publishing.

## Coolify

After the first successful publication, open the organization's `actions-runner`
package on GitHub and set its package visibility to **Public**. GHCR packages
default to private even when their source repository is public.

In **Server > GitHub Runners**, set **Runner image** to
`ghcr.io/xoxno/actions-runner:latest`, keep the `xoxno` custom label, and retain
**Isolated Docker (Sysbox)**. New jobs use the new image. For an explicit rollout,
select the immutable `sha-...` tag instead.

The image includes `build-essential` (make, GCC, G++, libc headers), pkg-config,
OpenSSL development headers, Python with venv support, and common CI utilities.
Workflows still select/install Rust, Node, Java, Stellar CLI, and other
job-specific tools. Local Certora prover bundles are not included; workflows
that expect a pre-existing `$HOME/certora-install` need explicit provisioning.

## Maintenance

Merge Dependabot updates regularly. GitHub stops accepting outdated runner
versions; do not let the pinned base image fall behind the supported window.
Rebuild by pushing to `main` or running the workflow manually to refresh OS
packages. Rebuilds of the same commit can include newer OS packages; use the
registry digest when exact image identity matters.

Only trusted workflows should use self-hosted infrastructure. Never bake tokens,
signing keys, or other credentials into this image.
