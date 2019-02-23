#!/bin/bash
python -m grpc_tools.protoc -I./ --python_out=. --grpc_python_out=. ./utd.proto
protoc utd.proto --swift_out=. --swiftgrpc_out=Client=true,Server=false:.
