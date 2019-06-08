function ans-role --description "Create a new Ansible role skeleton"
    set role_name $argv[1]
    if test -d roles -a ! -x $role_name
        mkdir -p roles/$role_name/{tasks,handlers,files,templates}
        begin
            echo "---"
            echo "# roles/$role_name/tasks/main.yaml"
            echo
        end > roles/$role_name/tasks/main.yaml
        begin
            echo "---"
            echo "# roles/$role_name/handlers/main.yaml"
            echo
        end > roles/$role_name/handlers/main.yaml
    else
        echo "Can't file roles directory."
    end
end

