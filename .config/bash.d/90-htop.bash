htop() {
	docker run --rm -it \
		--log-driver none \
		--pid host \
		--net none \
		--name htop \
		markcaudill/htop:latest
}
