require 'JSON'
ip_file = JSON.parse(File.read("config"))
ip = `curl ipinfo.io/ip -s`
File.open(ip_file['ip_location'], 'w+') do |file|
  file.puts ip
end
