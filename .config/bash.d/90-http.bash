http() {
	docker run --rm -t \
		--log-driver none \
		--name http \
		markcaudill/httpie:latest http "$@"
}
