#!/bin/bash -e
./scripts/verify-protoc-gen-go.sh

grpc_gateway_path=$(go list -m -f '{{.Dir}}' github.com/grpc-ecosystem/grpc-gateway)
googleapis_path="$grpc_gateway_path/third_party/googleapis"

echo "Generating protobuf for api/pb"
protoc -I. -I$googleapis_path --go_out=plugins=grpc:. api/pb/api.proto
protoc -I. -I$googleapis_path --grpc-gateway_out=logtostderr=true:. api/pb/api.proto
protoc -I. -I$googleapis_path --swagger_out=logtostderr=true:. api/pb/api.proto
