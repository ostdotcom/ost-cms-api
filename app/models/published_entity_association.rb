class PublishedEntityAssociation < ApplicationRecord
  serialize :associations, Array
end
