#!/usr/bin/env ruby

require 'base64'

file_name = ARGV.shift || (puts "Provide file name"; exit 1)

unless (File.exists?(file_name))
  puts "File not found :("
  exit 2
end

file = File.open(file_name, 'rb').read

img = Base64.strict_encode64(file)

img.gsub!('+', '-').gsub!('/', '_').gsub!('.', '=')

html = <<DATA
<html>
<head><title>Google Image</title></head><body>
<form id="f" method="POST" action="https://www.google.com/searchbyimage/upload"     enctype="multipart/form-data">
<input type="hidden" name="image_content" value="#{img}">
<input type="hidden" name="filename" value="">
<input type="hidden" name="image_url" value="">
<input type="hidden" name="sbisrc" value="cr_1_5_1">
</form>
<script>document.getElementById("f").submit();</script></body></html>
DATA

out = File.open('out.html', 'wb')
out.write(html)
out.close

`open out.html`
