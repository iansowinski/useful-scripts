ip = `curl ipinfo.io/ip -s`
File.open('/Users/janko/Dropbox/_active/skrypty/ip', 'w+') do |file|
  file.puts ip
end
