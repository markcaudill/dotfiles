export PS1="[\u@\h:\w]\$ "
umask 0077
export PATH=$HOME/perl5/bin:/bin:/usr/bin:/usr/pkg/bin:/usr/local/bin:$HOME/bin

weather() {
    # Check the weather. Source: https://coderwall.com/p/uhj-2a
    curl -s "http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml?query=${@:-"$1"}" | perl -ne '/<title>([^<]+)/&&printf "\x1B[0;34m%s\x1B[0m: ",$1;/<fcttext>([^<]+)/&&print $1,"\n"';}
