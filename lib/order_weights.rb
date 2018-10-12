class OrderWeights

  def get_new_record_weight(entity_id)

    if EntityDataVersion.where(:entity_id => entity_id).where(:status => [GlobalConstant::Models::EntityDataVersion.draft, GlobalConstant::Models::EntityDataVersion.active]).count == 0
      weight = GlobalConstant::AppConfig.new_entity_order_weight
    else
      weight = get_min_weight(entity_id) * (9.0 /10.0)
    end
    weight
  end

  def get_min_weight (entity_id)
    EntityDataVersion.where(:entity_id => entity_id).where(:status => [GlobalConstant::Models::EntityDataVersion.draft, GlobalConstant::Models::EntityDataVersion.active]).minimum("order_weight")
  end


end