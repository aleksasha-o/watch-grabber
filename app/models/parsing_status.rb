# frozen_string_literal: true

class ParsingStatus < ApplicationRecord
  def self.instance
    first_or_create
  end
end
