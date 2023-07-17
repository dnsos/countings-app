module AgeGroupHelper
  def age_group_label(min_age, max_age)
    (min_age && max_age) ? "#{min_age} – #{max_age}" : "#{min_age}+"
  end

  def age_groups_with_label(age_groups)
    age_groups.map do |age_group|
      AgeGroupWithLabel.new(age_group.id, age_group_label(age_group.min_age, age_group.max_age))
    end
  end

  class AgeGroupWithLabel
    attr_reader :id, :label

    def initialize(id, label)
      @id = id
      @label = label
    end
  end
end
