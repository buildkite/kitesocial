#!/bin/bash
set -euo pipefail

echo "--- Running RuboCop"
bundle exec rubocop
