module StoreAccessCounter
  private # Railsが以下のメソッドをcontroller上のアクションとして利用できるようにすることを防ぐ

  def set_counter
    @count = if session[:counter].nil?
      session[:counter] = 0
    else
      session[:counter] += 1
    end
  end

  def reset_counter
    session[:counter] = 0
  end
end
