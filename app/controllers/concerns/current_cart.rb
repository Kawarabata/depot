module CurrentCart
  private # Railsが以下のメソッドをcontroller上のアクションとして利用できるようにすることを防ぐ

  def set_cart
    @cart = Cart.find(session[:cart_id]) # セッションオブジェクトから:cart_idを取得してfind
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

  def set_counter
    @count = session[:counter].nil? ? 0 : session[:counter] + 1
  end
end
