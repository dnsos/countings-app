class Person < ApplicationRecord
  belongs_to :age_group
  belongs_to :gender
  belongs_to :counting
end
