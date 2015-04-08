class Cart < ActiveRecord::Base
  has_many :line_items, ->{includes(:product).order(:created_at)}, dependent: :destroy

  def add_item(p)
    line_item = line_items.where(product_id: p.id).first
    unless line_item
      line_item = self.line_items.build(product: p, quantity: 0, price: p.price)
    end
    line_item.quantity+=1
    line_item.save
  end
end
