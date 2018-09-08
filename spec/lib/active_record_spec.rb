# frozen_string_literal: true

require 'spec_helper'

module CodeKindly
  module Utils
    RSpec.describe 'ActiveRecord', active_record: true do
      describe :classes_by_connection do
        it 'contains one default set (no configurations setup)' do
          expect(ActiveRecord.classes_by_connection).to eq 'default' => [Companion, Doctor]
        end
      end

      describe :clear_scope do
        it 'returns nil if the scope is empty' do
          expect(ActiveRecord.clear_scope(Doctor.all)).to be nil
        end

        it "deletes the scope's records" do
          Doctor.create(number: 1, actor: 'William Hartnell')
          expect { ActiveRecord.clear_scope(Doctor.all) }.to change { Doctor.count }.from(1).to(0)
        end
      end

      describe :config do
        it 'returns all configs (nil in this context) by default' do
          expect(ActiveRecord.config).to be nil
        end
      end

      describe :configs do
        it 'has all AR configs (nil in this context)' do
          expect(ActiveRecord.configs).to eq({})
        end
      end

      describe :default_connection_class do
        it 'picks the first class' do
          expect(ActiveRecord.default_connection_class).to eq(Companion)
        end
      end
    end
  end
end
