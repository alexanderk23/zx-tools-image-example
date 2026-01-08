# ZX Spectrum Tools Docker Image Example

This example project demonstrates how to build ZX Spectrum software in a GitHub Actions workflow using the
[zx-tools-image](https://github.com/alexanderk23/zx-tools-image) Docker image that contains various tools for ZX Spectrum development.

### Workflow Process

The GitHub Actions workflow in [.github/workflows/build.yml](.github/workflows/build.yml) is triggered on pushes and pull requests
to the main branch and performs the following steps:

1. Checks out the source code from the repository
2. Runs the build process inside a Docker container with pre-installed ZX Spectrum development tools
3. Creates ZX Spectrum files (TAP, TRD, SCL, SNA) as build artifacts (in this example using Makefile, but this can be changed in the workflow to shell scripts, individual commands, etc.)
4. Uploads these files as [downloadable artifacts](https://github.com/alexanderk23/zx-tools-image-example/actions/runs/20826685890)
5. Creates [GitHub releases](https://github.com/alexanderk23/zx-tools-image-example/releases) when you tag your repository with version numbers like `v1.0.0`

### Release Process

When you create a Git tag matching the pattern `v[0-9]+.[0-9]+.[0-9]+` (like `v1.0.0`), the workflow automatically:

1. Builds your project
2. Creates a draft GitHub release
3. Attaches the generated ZX Spectrum files to the release

## Acknowledgments

- [PT3 Player code](http://bulba.untergrund.net) by **Sergey V. Bulba**
- [ZX0 compression routines](https://github.com/einar-saukas/ZX0) by **Einar Saukas**
- Music: [Alien 3 NES Title Theme](https://zxart.ee/eng/authors/n/nq/deltas-shadow---alien-3-nes-title-theme/) by **nq** (original by **Jeroen Tel**)
- Picture: [Alien31](https://zxart.ee/eng/authors/letter20332/ooo/alien31/) cover by **.oOo.**
