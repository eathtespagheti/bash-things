function docker-connect(){
    eval $(docker-machine env "$1")
}
