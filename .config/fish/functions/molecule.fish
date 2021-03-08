function molecule
	docker run --rm -it \
		--log-driver none \
		-v $PWD:$PWD \
		-v /var/run/docker.sock:/var/run/docker.sock \
		--name ansible_toolset \
		quay.io/ansible/toolset:latest /bin/bash -c "cd $PWD && molecule $argv"
end
