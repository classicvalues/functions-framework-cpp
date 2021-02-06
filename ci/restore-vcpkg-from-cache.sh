#!/usr/bin/env bash
# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -eu

if [[ $# -ne 1 ]]; then
  >&2 echo "Usage: $(basename "${0}") <VCPKG_ROOT>"
  exit 1
fi

readonly VCPKG_ROOT="${1}"

if [[ -x "${HOME}/.cache/bin/vcpkg" ]]; then
  cp "${HOME}/.cache/bin/vcpkg" "${VCPKG_ROOT}/vcpkg"
else
  (cd "${VCPKG_ROOT}"  && ./bootstrap-vcpkg.sh -useSystemBinaries)
  mkdir -p "${HOME}/.cache/bin"
  cp "${VCPKG_ROOT}/vcpkg" "${HOME}/.cache/bin/vcpkg"
fi
sha256sum "${VCPKG_ROOT}/vcpkg" || true
sha256sum "${HOME}/.cache/bin/vcpkg" || true