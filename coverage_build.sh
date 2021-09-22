#!/bin/bash
set -e

flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html