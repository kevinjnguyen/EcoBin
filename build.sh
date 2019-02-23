#!/bin/bash
python -m grpc_tools.protoc -I./ --python_out=./server --grpc_python_out=./server ./utd.proto
protoc utd.proto --swift_out=./ios --swiftgrpc_out=Client=true,Server=false:./ios
