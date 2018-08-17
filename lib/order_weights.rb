class OrderWeights

  def get_new_record_weight(entity_id)

    if EntityDataVersion.where(:entity_id => entity_id).where(:status => [0,1]).count == 0
      weight = 100000000000000000000000.0
    else
      weight = get_min_weight(entity_id) * (3.0 /4.0)
    end
    weight
  end

  def get_min_weight (entity_id)
    EntityDataVersion.where(:entity_id => entity_id ).where(:status => [0,1]).minimum("order_weight")
  end


end