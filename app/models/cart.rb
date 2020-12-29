class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product(product)
    current_item = line_items.find_by(product_id: product.id) # 引数productのidでline_itemsを探してくる
    if current_item # itemリストに追加する商品がすでに含まれているかどうかをチェックする
      current_item.quantity += 1 # あるなら量quantityを1追加
    else
      current_item = line_items.build(product_id: product.id, price: product.price) # なければこのproduct_idのline_itemを作ってbuildしてcurrent_item変数に追加
    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
