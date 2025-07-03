package main

import (
	"context"
	"errors"
	"fmt"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/cognitoidentityprovider"
)

// test trigger source
func main() {
	lambda.Start(handler)
}

func handler(ctx context.Context, event events.CognitoEventUserPoolsPreSignup) (events.CognitoEventUserPoolsPreSignup, error) {
	if event.TriggerSource == "PreSignUp_ExternalProvider" {
		return handlingFederatedSignUp(event)
	}

	return event, nil
}

func handlingFederatedSignUp(event events.CognitoEventUserPoolsPreSignup) (events.CognitoEventUserPoolsPreSignup, error) {
	email := event.Request.UserAttributes["email"]
	if email == "" {
		return event, errors.New("email is required for sign-up")
	}

	// Check if the email is already registered
	sess := session.Must(session.NewSession())
	svc := cognitoidentityprovider.New(sess)

	// Search for existing users with the same email
	input := &cognitoidentityprovider.ListUsersInput{
		UserPoolId: &event.UserPoolID,
		Filter:     aws.String(fmt.Sprintf("email = %q", email)),
		Limit:      aws.Int64(1),
	}

	users, err := svc.ListUsers(input)
	if err != nil {
		return event, err
	}
	if len(users.Users) != 0 {
		return event, errors.New("email already registered")
	}

	// Allow sign-up for users coming from an external provider
	event.Response.AutoConfirmUser = true
	event.Response.AutoVerifyEmail = true
	event.Response.AutoVerifyPhone = false // Assuming phone verification is not required for external providers

	return event, nil
}
