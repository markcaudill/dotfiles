function wlpop --description "List out WiFi channel populations"
  sudo iwlist wlp3s0 scan | grep \(Channel | awk '{print $3" "$4}' | sort -n | uniq -c | sort -rn
end
