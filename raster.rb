require 'rmagick'
include Magick

$start = Time.now
$this = $start
def time
  puts " : #{(Time.now - $this).round(1)}s"
  $this = Time.now
  return nil
end

width = 11811 
height = 8268
virtual = Image.new(2, 2)

print ""

print "loading"
img = Image.read("123.jpg").first()#.resize_to_fit!(width, height)
time()

print "converting to cmyk"
img.colorspace = Magick::CMYKColorspace
time()

print "channel separation"
a = img.separate(AllChannels)
time()

channels = ["c", "m", "y", "k"]
degrees = [15, 75, 0, 45]

a.each_with_index do |channel, index|
  next if index == 4
  puts "#{channels[index]}:"
  print "  resizing"
  channel = channel.resize_to_fill(width,height)
  time()
  print "  rotating"
  channel = channel.rotate(degrees[index])
  time()
  print "  dither"
  channel = channel.ordered_dither('h8x8o')
  time()
  print "  rotating back"
  channel = channel.rotate(-degrees[index])
  time()
  print "  writing"
  channel.write("#{channels[index]}.jpg")
  time()
end
print "Task ran for #{Time.now-$start}"
#http://www.imagemagick.org/Usage/quantize/#ordered-dither