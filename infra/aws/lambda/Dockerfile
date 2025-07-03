ARG LAMBDA_TASK

FROM golang:1.24 AS build
ARG LAMBDA_TASK
WORKDIR /lambda
# Copy dependencies list
COPY . .
# Download dependencies
RUN go mod download
# Build the Go app

RUN go build -o main endpoint/$LAMBDA_TASK/main.go

# Copy artifacts to a clean image
FROM public.ecr.aws/lambda/provided:al2023
COPY --from=build /lambda/main ./main
ENTRYPOINT [ "./main" ]