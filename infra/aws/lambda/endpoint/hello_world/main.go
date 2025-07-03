package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
)

type Response struct {
	Message string `json:"message"`
}

func HandleRequest(ctx context.Context) (Response, error) {
	fmt.Println("Received request in hello_world Lambda function")
	return Response{Message: "Hello, world!"}, nil
}

func main() {
	lambda.Start(HandleRequest)
}
