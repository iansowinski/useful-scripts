items = Dir.entries('.')

items.each do |item|
  puts "<img src='hasz/#{item}'> , #{item.gsub('jpg', '').gsub('jpeg', '').gsub('JPG', '')}"
end
