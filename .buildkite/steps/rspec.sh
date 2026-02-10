#!/bin/bash
set -euo pipefail

echo "--- Preparing test database"
bundle exec rails db:test:prepare

echo "--- Running RSpec tests"
bundle exec rspec
