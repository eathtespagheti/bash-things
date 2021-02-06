#!/usr/bin/env sh
# shellcheck disable=SC1090

CONFIG_FILE_NAME="gitlabManager.config"
DATA_FOLDER_NAME="gitlabManager"
API_ROOT="https://gitlab.com/api/v4"

initPaths() {
    [ -z "$XDG_CONFIG_HOME" ] && XDG_CONFIG_HOME="$HOME/.config"
    CONFIG_FILE="$XDG_CONFIG_HOME/$CONFIG_FILE_NAME"

    [ -z "$XDG_DATA_HOME" ] && XDG_DATA_HOME="$HOME/.local/share"
    DATA_FOLDER="$XDG_DATA_HOME/$DATA_FOLDER_NAME"

    [ ! -d "$DATA_FOLDER" ] && mkdir -p "$DATA_FOLDER"
}

checkUserVariables() {
    [ -n "$USER_ID" ] || [ -n "$PRIVATE_TOKEN" ]
}

updateProjectsList() {
    [ -n "$USER_ID" ] && {
        request="$API_ROOT/users/$USER_ID/projects"
        curl "$request" -o "$DATA_FOLDER/public.json" >/dev/null 2>&1 || {
            echo "Error getting projects from API"
            exit 2
        }
        request="$request?visibility=private"
        curl --header "Authorization: Bearer $PRIVATE_TOKEN" "$request" -o "$DATA_FOLDER/private.json" >/dev/null 2>&1 || {
            echo "Error getting projects from API"
            exit 2
        }
    }
    jq ".[]" "$DATA_FOLDER/public.json" "$DATA_FOLDER/private.json" >"$DATA_FOLDER/projects.json"
    rm "$DATA_FOLDER/public.json" "$DATA_FOLDER/private.json"
}

listProjects() {
    [ ! -f "$DATA_FOLDER/projects.json" ] && updateProjectsList

    jq -r "[.name, .description, .path, .ssh_url_to_repo] | @tsv" "$DATA_FOLDER/projects.json" |
        while IFS="" read -r line || [ -n "$line" ]; do
            name=$(echo "$line" | cut -f 1)
            description=$(echo "$line" | cut -f 2)
            path=$(echo "$line" | cut -f 3)
            url=$(echo "$line" | cut -f 4)
            printf "Name: %s\nDescrption: %s\nPath: %s\nURL: %s\n\n" "$name" "$description" "$path" "$url"
        done

}

initPaths

[ ! -f "$CONFIG_FILE" ] && {
    echo "Config file doesn't exist"
    checkUserVariables || exit 1
}
checkUserVariables || . "$CONFIG_FILE" # Source config file only if user variables aren't already set

[ ! -f "$DATA_FOLDER/projects.json" ] && updateProjectsList
listProjects
