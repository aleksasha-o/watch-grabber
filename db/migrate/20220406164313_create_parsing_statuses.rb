# frozen_string_literal: true

class CreateParsingStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :parsing_statuses do |t|
      t.boolean :running, null: false, default: false
    end
  end
end
