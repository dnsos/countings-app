# frozen_string_literal: true

require "time"

class Counting
  class HeaderComponentPreview < ViewComponent::Preview
    # Concluded
    #
    # @label Concluded counting
    def concluded
      render(
        Counting::HeaderComponent.new(
          title: "Erste Nacht der Solidarität in Berlin",
          starts_at: Time.parse("2020-01-29 22:00:00"),
          ends_at: Time.parse("2020-01-30 02:00:00")
        )
      )
    end

    # Ongoing
    # ----------------
    #
    # @label Ongoing counting
    def ongoing
      render(
        Counting::HeaderComponent.new(
          title: "Zweite Nacht der Solidarität in Berlin",
          starts_at: Time.now - 2.days,
          ends_at: Time.now + 2.days
        )
      )
    end

    # Finishing
    # ----------------
    #
    # @label Finishing counting
    def finishing
      render(
        Counting::HeaderComponent.new(
          title: "Dritte Nacht der Solidarität in Berlin",
          starts_at: Time.now - 2.days,
          ends_at: Time.now + 32.minutes
        )
      )
    end
  end
end
