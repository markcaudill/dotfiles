function dupdate --description "Update all Docker images."
	docker images --format '{{.Repository}}:{{.Tag}}' | xargs -n1 docker pull
end
