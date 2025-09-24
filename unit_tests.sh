#!/usr/bin/env bash
set -euo pipefail

CONTAINER="arvo-51132"        # name of the running container
TEST_OUTPUT="./test_output_51132.txt"  # where to save log on your Mac

echo "[+] Running Fluent Bit unit tests inside $CONTAINER ..."

# Execute build + test sequence inside the container
docker exec -i "$CONTAINER" bash -c '
  set -e
  cd /src/fluent-bit
  echo "[STEP 1] Cleaning and removing old build artifacts for a fresh CMake configure"
  rm -rf build && mkdir build

  echo
  echo "[STEP 2] Configuring CMake (Debug mode, enable tests, disable features missing dependencies)"
  cmake -S . -B build \
    -DCMAKE_BUILD_TYPE=Debug \
    -DFLB_TESTS=On \
    -DFLB_TESTS_INTERNAL=On \
    -DFLB_CONFIG_YAML=Off \
    -DFLB_FILTER_GEOIP2=Off \
    -DFLB_OUT_PGSQL=Off \
    -DFLB_IN_SYSTEMD=Off

  echo
  echo "[STEP 3] Building: compiling Fluent Bit and unit test binaries"
  cmake --build build -j"$(nproc)"

  echo
  echo "[STEP 4] Listing unit tests..."
  ctest --test-dir build -N

  echo
  echo "[STEP 5] Running tests..."
  ctest --test-dir build --output-on-failure | tee /tmp/test_output_51132.txt
'

echo
echo "[STEP 6] Copying test log artifact back to Mac..."
docker cp "$CONTAINER":/tmp/test_output_51132.txt "$TEST_OUTPUT"

echo "==> Done. Log saved to $TEST_OUTPUT"
