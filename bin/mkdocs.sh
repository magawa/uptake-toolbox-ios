#!/bin/bash

if which jazzy > /dev/null; then
  echo "Jazzy is installed."
else
  echo "Installing Jazzy..."
  gem install jazzy
fi

projectPath="$(find . -name "*.xcodeproj" -not -path "./Carthage/*" -print -quit)"
dir=$(dirname "${projectPath}")
marketingVersion=$(cd "${dir}";agvtool mvers -terse1)
jazzy --module-version "${marketingVersion}" --xcodebuild-arguments "-project","${projectPath}"
