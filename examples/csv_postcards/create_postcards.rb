require 'lob'
require 'csv'

# Initialize Lob object
Lob.api_key = 'test_0dc8d51e0acffcb1880e0f19c79b2f5b0cc'
@lob = Lob.load

# Load the HTML from postcard_front.html and postcard_back.html.
front_html = File.open(File.expand_path('../postcard_front.html', __FILE__)).read
back_html = File.open(File.expand_path('../postcard_back.html', __FILE__)).read

# Parse the CSV and create the postcards.
CSV.foreach(File.expand_path('../input.csv', __FILE__)) do |row|
  postcard = @lob.postcards.create(
    description: 'CSV Test',
    to: {
      name: row[5],
      address_line1: row[6],
      address_line2: row[7],
      city: row[8],
      state: row[9],
      zip: row[10],
      country: row[11]
    },
    from: {
      name: 'Lob',
      address_line1: '123 Main Street',
      city: 'San Francisco',
      state: 'CA',
      zip: '94185',
      country: 'US'
    },
    setting: 1002,
    front: front_html,
    back: back_html,
    data: {
      background_image: row[1],
      background_color: row[2],
      name: row[0],
      car: row[3],
      mileage: row[4]
    }
  )
  puts postcard['url']
end
