package main

import (
        "fmt"
        "context"
        "github.com/aws/aws-lambda-go/lambda"
)

//MyEvent struct
type MyEvent struct {
        Name string `json:"name"`
}

//HandleRequest - API request
func HandleRequest(ctx context.Context, name MyEvent) (string, error) {
        return fmt.Sprintf("Hello %s!", name.Name ), nil
}

func main() {
        lambda.Start(HandleRequest)
}