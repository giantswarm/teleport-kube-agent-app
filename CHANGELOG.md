# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.10.6] - 2025-07-09

## [0.10.5] - 2025-04-22

### Added

- Set Home URL in chart metadata.

## [0.10.4] - 2025-03-18

### Added
- Add headless service on `diag` port 3000.
### Changed
- Migrated to ABS

## [0.10.3] - 2024-09-26

### Changed

- Disable JAMF components on chart templates

## [0.10.2] - 2024-09-25

### Changed

- Fix issues with templates
- Change ownership to Team Shield

## [0.10.1] - 2024-09-04

- Added small fix on `podSecurityContext` for `seccompProfile`.

## [0.10.0] - 2024-08-21

### Changed

- Upgraded to Teleport `version 16`

## [0.9.2] - 2024-07-16

### Changed
- Introduced `podAntiAffinity` so `teleport-kube-agent` pods run on different `control-plane` nodes also increased the number of replicas to 3 to maintain better high availability.

## [0.9.1] - 2024-06-19

### Changed

- Changed the way registry is being parsed in helm templates

## [0.9.0] - 2024-04-18

### Added
- Add toleration for `node.cluster.x-k8s.io/uninitialized` and `node-role.kubernetes.io/control-plane` taint.
- Add node affinity to prefer scheduling pods to control-plane nodes.

## [0.8.0] - 2024-03-27

### Added
- Sync with upstream teleport-kube-agent@15.1.9 chart using vendir

## [0.7.1] - 2024-01-17

### Changed

- Use Azure registry

## [0.7.0] - 2024-01-02

### Added
- Enable high availability mode and podDisruptionBudget

## [0.6.0] - 2023-10-02

### Changed
- Propagate `global.podSecurityStandards.enforced` value set to `false` for PSS migration

## [0.5.0] - 2023-09-21

### Added
- Support for running behind a proxy

## [0.4.1] - 2023-08-15

### Fixed
- Meet schema spec

## [0.4.0] - 2023-08-10

### Fixed

- Push to default catalog

## [0.3.0] - 2023-08-03

### Added
- Remove playground catalog

## [0.2.0] - 2023-07-13

### Fixes
- Update Chart.yaml to [fix this](https://app.circleci.com/pipelines/github/giantswarm/teleport-kube-agent-app/1/workflows/e58da8df-838e-4118-9411-522ed1dec2ec/jobs/1)

### Added
- Sync with upstream chart

## [0.1.0] - 2023-06-28

### Added
- First release of teleport-kube-agent-app

[Unreleased]: https://github.com/giantswarm/teleport-kube-agent-app/compare/v0.10.6...HEAD
[0.10.6]: https://github.com/giantswarm/teleport-kube-agent-app/compare/v0.10.5...v0.10.6
[0.10.5]: https://github.com/giantswarm/teleport-kube-agent-app/compare/v0.10.4...v0.10.5
[0.10.4]: https://github.com/giantswarm/teleport-kube-agent-app/compare/v0.10.3...v0.10.4
[0.10.3]: https://github.com/giantswarm/teleport-kube-agent-app/compare/v0.10.2...v0.10.3
[0.10.2]: https://github.com/giantswarm/teleport-kube-agent-app/compare/v0.10.1...v0.10.2
[0.10.1]: https://github.com/giantswarm/teleport-kube-agent-app/compare/v0.10.0...v0.10.1
[0.10.0]: https://github.com/giantswarm/teleport-kube-agent-app/compare/v0.9.2...v0.10.0
[0.9.2]: https://github.com/giantswarm/teleport-kube-agent-app/compare/v0.9.1...v0.9.2
[0.9.1]: https://github.com/giantswarm/teleport-kube-agent-app/compare/v0.9.0...v0.9.1
[0.9.0]: https://github.com/giantswarm/teleport-kube-agent-app/compare/v0.8.0...v0.9.0
[0.8.0]: https://github.com/giantswarm/teleport-kube-agent-app/compare/v0.7.1...v0.8.0
[0.7.1]: https://github.com/giantswarm/teleport-kube-agent-app/compare/v0.7.0...v0.7.1
[0.7.0]: https://github.com/giantswarm/teleport-kube-agent-app/compare/v0.6.0...v0.7.0
[0.6.0]: https://github.com/giantswarm/teleport-kube-agent-app/compare/v0.5.0...v0.6.0
[0.5.0]: https://github.com/giantswarm/teleport-kube-agent-app/compare/v0.4.1...v0.5.0
[0.4.1]: https://github.com/giantswarm/teleport-kube-agent-app/compare/v0.4.0...v0.4.1
[0.4.0]: https://github.com/giantswarm/teleport-kube-agent-app/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/giantswarm/teleport-kube-agent-app/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/giantswarm/teleport-kube-agent-app/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/giantswarm/teleport-kube-agent-app/compare/v0.0.0...v0.1.0
