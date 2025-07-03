ARG LAMBDA_TASK

FROM golang:1.24 AS build
ARG LAMBDA_TASK
WORKDIR /lambda
# Copy dependencies list
COPY go.mod go.sum ./
# Download dependencies
RUN go mod download
# Copy the source code
COPY . .
# Build the Go app
ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64
RUN go build -ldflags '-s -w' -o main endpoint/$LAMBDA_TASK/main.go
RUN go build -o main endpoint/$LAMBDA_TASK/main.go

# Copy artifacts to a clean image
FROM public.ecr.aws/lambda/provided:al2023
COPY --from=build /lambda/main ./main
ENTRYPOINT [ "./main" ]