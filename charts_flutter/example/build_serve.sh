#!/bin/bash

if [ -d "build" ]; then
    echo "Deleting build folder..."
    rm -rf build
    echo "Build folder deleted successfully."
else
    echo "Build folder not found. Nothing to delete."
fi

echo "Running flutter clean..."
flutter clean

flutter build web --wasm

cd build/web

npx serve --config serve.json