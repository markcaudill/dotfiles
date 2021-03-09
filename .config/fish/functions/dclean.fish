function dclean --description "Clean up dangling Docker artifacts."
	docker system prune -f
end
