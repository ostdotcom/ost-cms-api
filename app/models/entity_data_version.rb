class EntityDataVersion < ApplicationRecord
  serialize :data, JSON
end
