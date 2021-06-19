# frozen_string_literal: true

require_relative '../spec_helper'

module CodeKindly
  module Utils
    RSpec.describe 'SQL', active_record: true do
      before :all do
        @doctor1 = Doctor.create(number: 1, actor: 'William Hartnell')
        @doctor1.companions.create(name: 'Susan Foreman', actor: 'Carole Ann Ford')
        @doctor1.companions.create(name: 'Barbara Wright', actor: 'Jaqueline Hill')
        @doctor1.companions.create(name: 'Ian Chesterton', actor: 'William Russell')
        @doctor2 = Doctor.create(number: 2, actor: 'Patrick Troughton')
        @doctor2.companions.create(name: 'Polly', actor: 'Anneke Wills')
      end

      after :all do
        @doctor1.destroy
        @doctor2.destroy
      end

      describe :select_all do
        it 'retrieves values with SQL input' do
          result = CK::SQL.select_all('SELECT actor, name from companions ORDER BY actor')
          expect(result.count).to eq 4
          expect(result.first).to eq('actor' => 'Anneke Wills', 'name' => 'Polly')
        end

        it 'retrieves aggregates' do
          result = CK::SQL.select_all('SELECT doctor_id, COUNT(*) AS c FROM companions GROUP BY doctor_id ORDER BY doctor_id DESC')
          expect(result.count).to eq 2
          expect(result.first).to eq('doctor_id' => @doctor2.id, 'c' => 1)
        end

        it 'retrieves values with an ActiveRecord scope' do
          result = CK::SQL.select_all(Companion.where(doctor: @doctor1).select(:actor, :name).order(:actor))
          expect(result.count).to eq 3
          expect(result.first).to eq('actor' => 'Carole Ann Ford', 'name' => 'Susan Foreman')
        end
      end

      describe :select_value do
        it 'retrieves an aggregate' do
          result = CK::SQL.select_value('SELECT COUNT(*) AS c FROM companions WHERE doctor_id = ' + @doctor2.id.to_s)
          expect(result).to eq 1
        end
      end

      describe :select_values do
        it 'retrieves values with SQL input' do
          result = CK::SQL.select_values('SELECT actor from companions ORDER BY actor')
          expect(result.count).to eq(4), result.inspect
          expect(result.first).to eq 'Anneke Wills'
        end

        it 'retrieves values with an ActiveRecord scope' do
          result = CK::SQL.select_values(Companion.where(doctor: @doctor1).select(:actor).order(:actor))
          expect(result.count).to eq(3), result.inspect
          expect(result.first).to eq 'Carole Ann Ford'
        end
      end
    end
  end
end
