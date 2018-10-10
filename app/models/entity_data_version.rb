class EntityDataVersion < ApplicationRecord
  serialize :data, JSON
  enum status: [:draft, :active, :deleted]
end
