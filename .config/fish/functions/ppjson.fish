function ppjson --description "Use python3 and pprint to clean up JSON from STDIN"
  python3 -c "import pprint, sys, json; pprint.pprint(json.load(sys.stdin))"
end
