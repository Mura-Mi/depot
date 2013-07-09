# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

Product.delete_all

Product.create([
{
  title: 'iPad 4',
  description:
    %{iPad is the whole new tablet device.},
  image_url: 'ipad4_2.jpg',
  price: 399.99
},
{
  title: 'iPhone5',
  description:
    %{iPhone5 is has 4 inch screen. <br>It's whole new product.},
  image_url: 'iphone5.jpg',
  price: 299.99
}
])

