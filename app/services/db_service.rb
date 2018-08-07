class DbService

  def self.create_data_version(request)
    data = request.POST
    entity_id = data["entity_id"]
    weight = OrderWeights.new.get_new_record_weight
    EntityDataVersion.create(data: data, order_weight:weight, entity_id: entity_id, status: 0)
    {success: true}
  end

  def self.edit_data_version(request)
    data = request.POST["data"]
    id = request.POST["id"]
    entity = EntityDataVersion.find_by_id(id)
    entity.status = 2
    entity.save
    EntityDataVersion.create(data: data, order_weight: entity[:order_weight], entity_id: entity[:entity_id], status: 0)
    {success: true}
  end

  def self.delete_data_version(request)
    id = request.POST["id"]
    entity_to_delete = EntityDataVersion.find_by_id(id)
    entity_to_delete.status = 1
    entity_to_delete.save
    {success: true}
  end


  def self.publish_data(request)
    entity_id = request.POST["entity_id"]
    entities = EntityDataVersion.where(["status = '0'", "entity_id = '"+ entity_id +"'"]).order(:order_weight)
    ordered_array = []
    entities.each do |entity|
      ordered_array.push(entity.id)
    end
    PublishedEntityAssociation.create(associations: ordered_array, environment:"DEV", entity_id:entity_id)
    {success:true}
  end

  def self.get_published_data(request)
    published_list = []
    entity_id = request.GET["entity_id"]
    published_data = PublishedEntityAssociation.where("entity_id = '"+ entity_id +"'").last
    published_data.associations.each do |element|
      entity = EntityDataVersion.where( "id = '"+ element.to_s() +"'").first
      published_list.push({record: entity.data, id:entity.id})
    end
    {
        success: true,
        data: published_list
    }
  end

end