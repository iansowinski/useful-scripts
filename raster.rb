require 'rmagick'
include Magick
require 'thread'

$start = Time.now
$this = $start
$threads = []
def time
  var = " : #{(Time.now - $this).round(1)}s"
  $this = Time.now
  return var
end

width = 1181#1 
height = 826#8

img = Image.read("123.jpg").first()
puts "loading#{time()}"
org_width = img.columns
org_height = img.rows

puts "#{org_width} x #{org_height}"

img.colorspace = Magick::CMYKColorspace
puts "converting to cmyk#{time()}"


a = img.separate(AllChannels)
puts "channel separation#{time()}"

channels = ["CYAN", "MAGENTA", "YELLOW", "KEY"]
degrees = [15, 75, 0, 45]

a.each_with_index do |channel, index|
  next if index == 4
  
  # channel = channel.resize_to_fill(width,height)
  # puts "#{channels[index]}: resizing#{time()}"
  
  print "#{channels[index]}: rotating"
  channel = channel.rotate(-degrees[index])
  puts time()
  
  print "#{channels[index]}: dither"
  channel = channel.ordered_dither('h8x8o')
  puts time()
  
  print "#{channels[index]}: rotating back"
  channel = channel.rotate(degrees[index])
  puts time()

  # channel = channel.crop(channel.columns/2, channel.rows/2, org_width, org_height)
  
  print "#{channels[index]}: writing"
  channel.write("#{channels[index]}.jpg")
  puts time()
end
print "Task ran for #{Time.now-$start}"

# Uncomment if on debian
#`sudo find /tmp/ -name "magick-*" -type f -delete`
#http://www.imagemagick.org/Usage/quantize/#ordered-dither