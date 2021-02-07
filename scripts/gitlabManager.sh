#!/usr/bin/env sh
# shellcheck disable=SC1090

CONFIG_FILE_NAME="gitlabManager.config"
DATA_FOLDER_NAME="gitlabManager"
PROJECTS_FILE_NAME="projects.json"
API_ROOT="https://gitlab.com/api/v4"
VERBOSE="false"
ACTION="help"
REPO=""

printHelp() {
    printf "Parameters:\n\n"
    printf "%s:\n\t%s\n" "-h, --help" "Print this message"
    printf "%s:\n\t%s\n" "-v, --verbose" "Enable verbose mode"
    printf "%s:\n\t%s\n" "-ui, --user-id <user id>" "Set USER_ID"
    printf "%s:\n\t%s\n" "-pt, --private-token <token>" "Set PRIVATE_TOKEN"
    printf "%s:\n\t%s\n" "-cf, --config-file <path/to/config/file>" "Use a different config file"
    printf "%s:\n\t%s\n" "-pf, --projects-file <path/to/projects/file>" "Use a different projects file"
    printf "\nActions:\n\n"
    printf "%s:\n\t%s\n" "clone, -c <repo-path>" "Clone repo"
    printf "%s:\n\t%s\n" "list, -l" "List all repos"
    printf "%s:\n\t%s\n" "update, -u" "Update projects list"
    exit 0
}

parseArgs() {
    for arg in "$@"; do
        case "$arg" in
        -v)
            VERBOSE="true"
            [ "$VERBOSE" = "true" ] && echo "Enable Verbose"
            shift
            ;;
        --verbose)
            VERBOSE="true"
            [ "$VERBOSE" = "true" ] && echo "Enable Verbose"
            shift
            ;;
        -ui)
            shift
            USER_ID="$1"
            [ "$VERBOSE" = "true" ] && echo "Set user id to $USER_ID"
            ;;
        --user-id)
            shift
            USER_ID="$1"
            [ "$VERBOSE" = "true" ] && echo "Set user id to $USER_ID"
            ;;
        -pt)
            shift
            PRIVATE_TOKEN="$1"
            [ "$VERBOSE" = "true" ] && echo "Set private token to $PRIVATE_TOKEN"
            ;;
        --private-token)
            shift
            PRIVATE_TOKEN="$1"
            [ "$VERBOSE" = "true" ] && echo "Set private token to $PRIVATE_TOKEN"
            ;;
        -cf)
            shift
            CONFIG_FILE="$1"
            [ "$VERBOSE" = "true" ] && echo "Use $CONFIG_FILE as config file"
            ;;
        --config-file)
            shift
            CONFIG_FILE="$1"
            [ "$VERBOSE" = "true" ] && echo "Use $CONFIG_FILE as config file"
            ;;
        -pf)
            shift
            PROJECTS_FILE="$1"
            [ "$VERBOSE" = "true" ] && echo "Use $PROJECTS_FILE as projects file"
            ;;
        --projects-file)
            shift
            PROJECTS_FILE="$1"
            [ "$VERBOSE" = "true" ] && echo "Use $PROJECTS_FILE as projects file"
            ;;
        -h)
            printHelp
            shift
            ;;
        --help)
            printHelp
            shift
            ;;
        -c)
            ACTION="clone"
            shift
            REPO="$1"
            ;;
        clone)
            ACTION="clone"
            shift
            REPO="$1"
            ;;
        -l)
            ACTION="list"
            shift
            ;;
        list)
            ACTION="list"
            shift
            ;;
        -u)
            ACTION="update"
            shift
            ;;
        update)
            ACTION="update"
            shift
            ;;
        *)
            shift
            ;;
        esac

    done
}

checkDependencies() {
    command -v curl >/dev/null 2>&1 || {
        echo "curl not installed"
        exit 3
    }
    command -v jq >/dev/null 2>&1 || {
        echo "jq not installed"
        exit 3
    }
}

initPaths() {
    [ -z "$XDG_CONFIG_HOME" ] && XDG_CONFIG_HOME="$HOME/.config"
    CONFIG_FILE="$XDG_CONFIG_HOME/$CONFIG_FILE_NAME"

    [ -z "$XDG_DATA_HOME" ] && XDG_DATA_HOME="$HOME/.local/share"
    DATA_FOLDER="$XDG_DATA_HOME/$DATA_FOLDER_NAME"
    PROJECTS_FILE="$DATA_FOLDER/$PROJECTS_FILE_NAME"

    [ ! -d "$DATA_FOLDER" ] && {
        [ "$VERBOSE" = "true" ] && echo "Creating data folder in $DATA_FOLDER"
        mkdir -p "$DATA_FOLDER"
    }
}

checkUserVariables() {
    [ -n "$USER_ID" ] || [ -n "$PRIVATE_TOKEN" ]
}

loadConfigFile() {
    [ ! -f "$CONFIG_FILE" ] && {
        echo "Config file doesn't exist"
        checkUserVariables || exit 1
    }
    [ "$VERBOSE" = "true" ] && echo "Loading config file"
    . "$CONFIG_FILE" # Source config file only if user variables aren't already set
}

updateProjectsList() {
    [ "$VERBOSE" = "true" ] && echo "Updating projects list in $PROJECTS_FILE"
    if [ -n "$PRIVATE_TOKEN" ]; then
        request="$API_ROOT/projects?min_access_level=10"
        [ "$VERBOSE" = "true" ] && echo "Retrieving public projects from $request"
        curl --header "Authorization: Bearer $PRIVATE_TOKEN" "$request" -o "$DATA_FOLDER/public.json" >/dev/null 2>&1 || {
            echo "Error getting projects from API"
            exit 2
        }
        request="$request&visibility=private"
        [ "$VERBOSE" = "true" ] && echo "Retrieving private projects from $request"
        curl --header "Authorization: Bearer $PRIVATE_TOKEN" "$request" -o "$DATA_FOLDER/private.json" >/dev/null 2>&1 || {
            echo "Error getting projects from API"
            exit 2
        }
    elif [ -n "$USER_ID" ]; then
        request="$API_ROOT/users/$USER_ID/projects"
        [ "$VERBOSE" = "true" ] && echo "Retrieving public projects from $request"
        curl "$request" -o "$DATA_FOLDER/public.json" >/dev/null 2>&1 || {
            echo "Error getting projects from API"
            exit 2
        }
        request="$request?visibility=private"
        [ "$VERBOSE" = "true" ] && echo "Retrieving private projects from $request"
        curl --header "Authorization: Bearer $PRIVATE_TOKEN" "$request" -o "$DATA_FOLDER/private.json" >/dev/null 2>&1 || {
            echo "Error getting projects from API"
            exit 2
        }
    else
        echo "No User ID or Private Token provided!"
        exit 4
    fi

    [ "$VERBOSE" = "true" ] && echo "Merging public and private projects"
    jq ".[]" "$DATA_FOLDER/public.json" "$DATA_FOLDER/private.json" >"$PROJECTS_FILE"
    rm "$DATA_FOLDER/public.json" "$DATA_FOLDER/private.json"
}

printProject() {
    name=$(echo "$line" | cut -f 1)
    description=$(echo "$line" | cut -f 2)
    path=$(echo "$line" | cut -f 3)
    url=$(echo "$line" | cut -f 4)
    printf "Name: %s\nDescrption: %s\nPath: %s\nURL: %s\n\n" "$name" "$description" "$path" "$url"
}

listProjects() {
    [ "$VERBOSE" = "true" ] && echo "Checking if projects file exist"
    [ ! -f "$PROJECTS_FILE" ] && updateProjectsList

    jq -r "[.name, .description, .path_with_namespace, .ssh_url_to_repo] | @tsv" "$PROJECTS_FILE" |
        while IFS="" read -r line || [ -n "$line" ]; do
            printProject "$line"
        done

}

cloneProject() {
    echo "Cloning $REPO"
}

execAction() {
    case "$ACTION" in
    list)
        listProjects
        ;;
    help)
        printHelp
        ;;
    clone)
        cloneProject
        ;;
    update)
        updateProjectsList
        ;;
    *)
        listProjects
        ;;
    esac

}

initPaths
checkDependencies
loadConfigFile
parseArgs "$@"
execAction
