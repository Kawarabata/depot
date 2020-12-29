class CombineItemsInCart < ActiveRecord::Migration[6.1]
  def up
    Cart.all.each do |cart|
      # 各カートに関連づけれらたline_itemのquantityフィールドの合計をproductごとに取得してhashにする
      sums = cart.line_items.group(:product_id).sum(:quantity)  # { 1: 3, 2: 3 }

      sums.each do |product_id, quantity|
        if quantity > 1
          cart.line_items.where(product_id: product_id).delete_all # カート内のそのproduct_idのline_itemsを全部消す

          item = cart.line_items.build(product_id: product_id) # そのproduct_idのline_itemを作る
          item.quantity = quantity # sumsに入っていたquantityをセット
          item.save! # 保存
        end
      end
    end
  end

  def down
    LineItem.where('quantity > 1').each do |line_item|
      line_item.quantity.times do
        LineItem.create(
          cart_id: line_item.cart_id,
          product_id: line_item.product_id,
          quantity: 1
        )
      end
      line_item.destroy
    end
  end
end
