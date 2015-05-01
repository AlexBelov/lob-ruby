$:.unshift File.expand_path("../lib", File.dirname(__FILE__))
require 'open-uri'
require 'prawn'
require 'lob'

# initialize Lob object
Lob.api_key = 'test_0dc8d51e0acffcb1880e0f19c79b2f5b0cc'
@lob = Lob.load

POINTS_PER_INCH = 72 # 72 PostScript Points per Inch

pdf = Prawn::Document.new(:page_size => [4.25 * POINTS_PER_INCH, 6.25 * POINTS_PER_INCH])
pdf.image open('https://s3-us-west-2.amazonaws.com/lob-assets/printing_icon.png'), :position => :center
pdf.text 'Print with Lob!', :align => :center, :size => 32

pdf.render_file 'sample.pdf'

object = @lob.objects.create(
  description: 'Test Object',
  file: File.new('sample.pdf'),
  setting: 201
)

puts 'You can view your created PDF here: ' + object['url']
