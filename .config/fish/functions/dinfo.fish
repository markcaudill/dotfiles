function dinfo --description "Domain info"
    set domain $argv[1]
    echo "WHOIS"
    echo "====="
    whois $domain
    echo

    echo "SSL"
    echo "==="
    set ssl_expiration_date (openssl s_client -connect $domain:443 < /dev/null ^ /dev/null | openssl x509 -noout -enddate | awk -F'=' '{print $2}')
    echo "SSL Expiration: $ssl_expiration_date"
    echo

    echo "DNS"
    echo "==="
    set basedomain (echo $domain | awk -F'.' '{print $(NF-1)"."$NF}')
    begin
        if test $domain != $basedomain
            host $basedomain
        end
        host $domain
    end | sort | uniq
    echo
end
