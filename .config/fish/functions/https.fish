function https
    docker run --rm -t \
        --log-driver none \
        --name https \
        markcaudill/httpie:latest https $argv
end
