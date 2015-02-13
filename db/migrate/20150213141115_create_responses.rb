class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.belongs_to :survey
      t.belongs_to :answer
    end
  end
end
