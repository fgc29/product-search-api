File.foreach('db/seed_data/products.csv').with_index do |line_text, row|
  next if row.zero?

  product     = line_text.split('",')
  name        = product[1].gsub!(/"/,'').strip
  image       = product[2].gsub!(/"/,'').strip
  description = product[3].gsub!(/"/,'').strip

  Product.create({
                     name:        name,
                     image:       image,
                     description: description
                 })
end

File.foreach('db/seed_data/inventories.csv').with_index do |line_text, row|
  next if row.zero?

  inventory = line_text.split(',')

  Inventory.create({
                       product_id: inventory[0].strip.to_i,
                       waist:      inventory[1].strip.to_i,
                       length:     inventory[2].strip.to_i,
                       style:      inventory[3].strip,
                       count:      inventory[4].strip.to_i
                   })
end