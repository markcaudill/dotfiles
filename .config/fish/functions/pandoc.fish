function pandoc
	docker run --rm \
		-i \
		--log-driver none \
		--net none \
		--name pandoc \
		--volume (pwd):/data \
		--user (id -u):(id -g) \
		pandoc/core $argv
end
