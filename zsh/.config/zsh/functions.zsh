function connect() {
    ssh -N -L $1:$2:$1 $3
}
