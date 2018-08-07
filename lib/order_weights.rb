class OrderWeights

  def get_new_record_weight
    if EntityDataVersion.count == 0
      weight = 1.0
    else
      weight = get_min_weight / 2.0
    end
    weight
  end

  def get_min_weight
    EntityDataVersion.minimum("order_weight")
  end


end