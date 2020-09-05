# Resubmission

* In this resubmission, I have fixed C++ code and tested with `rhub::check_with_sanitizers()` to address UBSAN errors.

# Test environments
* Local R installation, R 4.0.2 on Windows 10
* GitHub Action
    * R 4.1.0-devel on Mac OS X 10.15.4
    * R 4.0.2 on Windows Server 2019, Mac OS X 10.15.4 and Ubuntu 16.04
    * R 3.3, 3.4, 3.5, and 3.6 on Ubuntu 16.04
* R 4.1.0-devel on win-builder
* r-hub
    * R 4.1.0-devel with GCC ASAN/UBSAN on Debian
    * R 4.1.0-devel on Windows Server 2008 and Fedora Linux
    * R 4.0.0 on Ubuntu 16.04

# R CMD check results

0 errors | 0 warnings | 1 note

* Days since last update: 2
    * The previous release of this package raised UBSAN errors. This release fixes them.
