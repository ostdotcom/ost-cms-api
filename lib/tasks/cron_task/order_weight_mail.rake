namespace :cron_task do

  # Check minimum order weights of all entities and send mail if order weight is less than threshold
  #
  # * Author: Mayur
  # * Date: 22/10/2018
  # * Reviewed By:
  #
  desc "rake RAILS_ENV=development cron_task:order_weight_mail"
  desc "0 0 12 1/1 * ? * cd /mnt/ost_web/current && rake RAILS_ENV=development cron_task:order_weight_mail"
    task :order_weight_mail  => [:environment] do |task|
      threshold_weight = GlobalConstant::AppConfig.threshold_order_weight
      less_order_weight_entities = []

      entities = EntityDataVersion.group(:entity_id).minimum(:order_weight)
      entities.each do |entity_id, order_weight|
        if order_weight <= threshold_weight
          entity = Entity.find_by_id(entity_id)
          less_order_weight_entities << {id: entity_id, name: entity.name, order_weight: order_weight }
        end
      end
      if less_order_weight_entities.count != 0
        mail_order_weights(less_order_weight_entities)
      end

    end


   def mail_order_weights(arr)
     ApplicationMailer.notify(
         to: GlobalConstant::Email.order_weight_watchers,
         body: {},
         data: {
             entities: arr
         },
         subject: 'Entity Order weight Alert'
     ).deliver
   end





end