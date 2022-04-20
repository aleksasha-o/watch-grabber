# frozen_string_literal: true

module Items
  class Index
    def initialize(params)
      @params = params
    end

    def ransack_search
      @ransack_search ||= Item.ransack(@params)
    end

    def ransack_items
      @ransack_items ||= ransack_search.result(distinct: true)
    end

    def brands_for_select
      Item.pluck(:brand).each { |brand| brand.humanize.capitalize }.uniq.sort
    end

    def default_min_price
      Item.pluck(:price)&.min&.round
    end

    def default_max_price
      Item.pluck(:price)&.max&.round
    end

    def current_min_price
      @params.present? && @params[:price_gteq].present? ? @params[:price_gteq] : default_min_price
    end

    def current_max_price
      @params.present? && @params[:price_lteq].present? ? @params[:price_lteq] : default_max_price
    end
  end
end
