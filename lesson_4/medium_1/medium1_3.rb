class InvoiceEntry
  attr_accessor :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    self.quantity = updated_count if updated_count >= 0
  end
end

# One way to fix this is to change attr_reader to attr_accessor and change quantity
# to self.quantity.

# Is there anything wrong with fixing it this way?

inv = InvoiceEntry.new('fruit', 4)
p inv.quantity
inv.update_quantity(5)
p inv.quantity

# Can also use the #quantity setter method to update the variable without the protection
# of the #update_quantity method
