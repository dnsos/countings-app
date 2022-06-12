# frozen_string_literal: true

class Counting
  class HeaderComponent < ViewComponent::Base
    def initialize(title:, starts_at:, ends_at:, **args)
      @title = title
      @starts_at = starts_at
      @ends_at = ends_at
      @args = args

      @remaining_time =
        if ongoing?
          "#{distance_of_time_in_words(Time.now, @ends_at)} 
              #{I18n.t('common.remaining')}"
        end
    end

    def ongoing?
      Time.now.between? @starts_at, @ends_at
    end
  end
end
