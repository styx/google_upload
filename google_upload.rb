#!/usr/bin/env ruby

require 'base64'

file = File.open('icon.jpg', 'rb').read

img = Base64.strict_encode64(file).chomp

img.gsub!('+', '-').gsub!('/', '_').gsub!('.', '=')


img = '<html><head><title>Google Image</title></head><body><form id="f" method="POST" action="https://www.google.com/searchbyimage/upload" enctype="multipart/form-data"><input type="hidden" name="image_content" value="' +
  img + '"><input type="hidden" name="filename" value=""><input type="hidden" name="image_url" value=""><input type="hidden" name="sbisrc" value="cr_1_5_1"></form><script>document.getElementById("f").submit();</script></body></html>';


f = "data:text/html;charset=utf-8;base64,#{Base64.strict_encode64(img).chomp}"

puts f
