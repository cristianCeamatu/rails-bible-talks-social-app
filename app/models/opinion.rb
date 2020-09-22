class Opinion < ApplicationRecord
  belongs_to :author, class_name: 'User'

  validates :text, presence: true, length: { minimum: 2, maximum: 500 }
end
