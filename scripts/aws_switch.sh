#!/usr/bin/env sh

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
CONFIG_FILE_NAME=aws_switch.conf
CONFIG_FILE=$XDG_CONFIG_HOME/$CONFIG_FILE_NAME

# From the config file load the id associated with the profile
# Config file it's written in the format

# ```
# profile_name profile_id
# ```

# e.g.

# ```
# staging 123456789
# production 987654321
# ```
get_role_id() {
	profile_name=$1
	profile_id=$(grep -i "$profile_name" "$CONFIG_FILE" | cut -d' ' -f2)
	echo "$profile_id"
}

list_configuration() {
	# For every line in the configuration file
	# print the profile name and the role id
	while read -r line; do
		profile_name=$(echo "$line" | cut -d' ' -f1)
		profile_id=$(echo "$line" | cut -d' ' -f2)
		printf "%-8s\t%s\n" "$profile_name" "$profile_id"
	done <"$CONFIG_FILE"
}

list_available_profiles() {
	# For every line in the configuration file print the profile name
	while read -r line; do
		profile_name=$(echo "$line" | cut -d' ' -f1)
		printf "%s " "$profile_name"
	done <"$CONFIG_FILE"
	printf "\n"
}

completion_targets() {
	profiles="$(list_available_profiles | tr '\n' ' ')"
	commands="root help completions list list-config"
	echo "$commands $profiles"
}

aws_switch_env() {
	ACCOUNTID="$1"
	AWS_JSON="$(AWS_PAGER="" aws sts assume-role --role-arn "arn:aws:iam::$ACCOUNTID:role/OfCourseMe-CrossAccountAdminRole" --role-session-name mfa-base --output json)"
	AWS_ACCESS_KEY_ID="$(echo "$AWS_JSON" | jq -r '.Credentials.AccessKeyId')"
	AWS_SECRET_ACCESS_KEY="$(echo "$AWS_JSON" | jq -r '.Credentials.SecretAccessKey')"
	AWS_SESSION_TOKEN="$(echo "$AWS_JSON" | jq -r '.Credentials.SessionToken')"
	export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
}

aws_switch_root() {
	unset AWS_ACCESS_KEY_ID
	unset AWS_SECRET_ACCESS_KEY
	unset AWS_SESSION_TOKEN
}


[ "$1" = "help" ] && printf "Usage:\n. %s <account_id>\n\naccount_id could also be \"production\" or \"staging\"\nIf account_id it's \"root\" or missing role will be unset to the default one from aws configuration\n" "$0" && exit 1
[ "$1" = "list-config" ] && list_configuration && exit 0
[ "$1" = "list" ] && list_available_profiles && exit 0
[ "$1" = "completions" ] && completion_targets && exit 0
# If the first argument is root or empty
[ "$1" = "root" ] && aws_switch_root && exit 0
[ -z "$1" ] && aws_switch_root && exit 0
# If the first argument is everything else
aws_switch_env "$(get_role_id "$1")"
