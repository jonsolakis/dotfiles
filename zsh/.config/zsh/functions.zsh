# shellcheck disable=SC1073
dka() {
    for container in $(docker ps -q); do
        docker kill "$container"
    done
}

docker_kill_all() {
    echo "dka is the shorthand ya dummy"
    for container in $(docker ps -q); do
        docker kill "$container"
    done
}

tempe () {
  cd "$(mktemp -d)"
  chmod -R 0700 .
  if [[ $# -eq 1 ]]; then
    \mkdir -p "$1"
    cd "$1"
    chmod -R 0700 .
  fi
}

mkcd () {
  \mkdir -p "$1"
  cd "$1"
}

