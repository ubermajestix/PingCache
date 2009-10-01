#!/opt/local/bin/ruby
`ifconfig | grep broadcast | cut -d " " -f6 | xargs -0 ping -c2`
macs = `arp -a | cut -d" " -f4`
puts macs.split("\n").inspect