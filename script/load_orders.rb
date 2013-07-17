Order.transaction do
  (1..100).each do |i|
    Order.create(:name => "Customer #{i}", :address => "#{i} main street", :email => "customer-#{i}@example.com", :pay_type => "CASH")
  end
end
