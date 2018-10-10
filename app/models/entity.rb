class Entity < ApplicationRecord
  enum status: [:draft, :published, :previewed]

end
