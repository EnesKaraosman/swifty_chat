#!/bin/bash
set -e

flutter test --coverage
lcov --remove coverage/lcov.info "**/*.g.dart" -o coverage/lcov_cleaned.info
genhtml coverage/lcov_cleaned.info -o coverage/html
