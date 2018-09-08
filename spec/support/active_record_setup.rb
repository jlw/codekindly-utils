# frozen_string_literal: true

require 'sqlite3'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

ActiveRecord::Schema.define do
  create_table :doctors, force: true do |t|
    t.string :actor
    t.integer :number
  end
  create_table :companions, force: true do |t|
    t.string :actor
    t.string :name
    t.references :doctor
  end
end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
class Doctor < ApplicationRecord
  has_many :companions
end
class Companion < ApplicationRecord
  belongs_to :doctor
end
