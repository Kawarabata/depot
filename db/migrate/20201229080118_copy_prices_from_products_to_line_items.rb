class CopyPricesFromProductsToLineItems < ActiveRecord::Migration[6.1]
  def up
    Product.all.each do |product|
      # productに紐づくline_itemsのpriceに、product.priceの値を入れる
      product.line_items.each do |line_item|
        line_item.update!(price: product.price)
      end
    end
  end
end
