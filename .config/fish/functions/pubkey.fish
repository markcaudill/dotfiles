function pubkey
  cat ~/.ssh/*.pub \
    | sort | uniq \
    | xclip -selection clipboard
    echo "🛈 Public key copied to clipboard"
end
