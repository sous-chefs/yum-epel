# Limitations

## Package Availability

### DNF/YUM

* EPEL 8 is published for the RHEL 8 family and compatible rebuilds.
* EPEL 9 is published for the RHEL 9 family and CentOS Stream 9.
* EPEL 10 is published for the RHEL 10 family and CentOS Stream 10. The Fedora EPEL branch model uses EPEL 10 repositories for the leading CentOS Stream 10 branch and separate EPEL 10.x repositories for trailing RHEL 10 minor versions.
* EPEL Next is modeled only for CentOS Stream releases where Fedora publishes Next repositories. This cookbook enables `epel-next` by default on CentOS Stream 9 and does not enable it by default on Enterprise Linux 10.
* Amazon Linux 2023 is treated as EPEL 9 compatible by this cookbook. Fedora EPEL documentation describes RHEL and CentOS Stream targets, not Amazon Linux as an official EPEL target.

### APT and Zypper

* EPEL is a DNF/YUM repository project. This cookbook does not manage APT or Zypper repositories.

## Architecture Limitations

* Repository URLs use Fedora mirrorlists with `$basearch`, so architecture selection is delegated to Fedora mirrors and the target platform.
* CentOS Stream 10 publishes x86_64_v3, aarch64, ppc64le, and s390x builds. EPEL 10 follows the Enterprise Linux 10 ecosystem and inherits the practical architecture constraints of those targets.
* The legacy `armv7l` and `armv7hl` special-case base URL and `s390x` EPEL 7 release candidate URL are preserved for compatibility in helper defaults, but those platforms are not in the modern test matrix.

## Source/Compiled Installation

This cookbook configures repositories only. It does not build EPEL packages from source.

## Known Issues

* RHEL 7, CentOS Linux 7, Oracle Linux 7, Scientific Linux, and zLinux support was removed because the RHEL 7 family reached end of life on June 30, 2024 and current Fedora EPEL branch documentation covers EPEL 8, 9, and 10.
* Amazon Linux 2 reaches end of support on June 30, 2026, but it maps to EPEL 7 in this cookbook's legacy behavior and EPEL 7 is no longer a current target.

## Sources

* Fedora EPEL branches: https://tdawson.fedorapeople.org/epel-docs/public/epel/branches/
* Fedora epel-release package overview: https://packages.fedoraproject.org/pkgs/epel-release/epel-release/
* Fedora EPEL Next overview: https://fedoraproject.org/wiki/EPEL_Next
* CentOS Stream 10 release notes: https://www.centos.org/centos10/
* RHEL lifecycle: https://endoflife.date/rhel
* Amazon Linux 2 FAQ: https://aws.amazon.com/amazon-linux-2/faqs/
