#!/usr/bin/env sh

AWS_MFA_CONFIG_FILE="$HOME/.aws/credentials"
BASE_PROFILE=mfa-base

loadVariables() {
    [ -n "$AWS_MFA_ARN" ] && return 0
    [ ! -f "$AWS_MFA_CONFIG_FILE" ] && echo "$AWS_MFA_CONFIG_FILE not found" && exit 1
    AWS_MFA_ARN="$(aws configure get aws_mfa_arn --profile "$BASE_PROFILE")"
}

loadVariables
[ -z "$AWS_MFA_ARN" ] && printf "AWS MFA ARN not provided, write it in \$AWS_MFA_ARN or set it with:\naws configure set aws_mfa_arn <yourawsmfaarn> --profile %s\n" "$BASE_PROFILE" && exit 2

printf "Insert OTP code: "
read -r tokenCode

tokenResponse="$(aws sts get-session-token --serial-number "$AWS_MFA_ARN" --token-code "$tokenCode" --profile "$BASE_PROFILE" --output yaml)" && {
    accessKeyId="$(echo "$tokenResponse" | grep AccessKeyId: | cut -d ' ' -f 4)"
    secretAccessKey="$(echo "$tokenResponse" | grep SecretAccessKey: | cut -d ' ' -f 4)"
    sessionToken="$(echo "$tokenResponse" | grep SessionToken: | cut -d ' ' -f 4)"

    aws configure set aws_access_key_id "$accessKeyId" --profile default
    aws configure set aws_secret_access_key "$secretAccessKey" --profile default
    aws configure set aws_session_token "$sessionToken" --profile default
}
