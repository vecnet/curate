require 'spec_helper'
require "cancan/matchers"

describe "User" do
  describe "Abilities" do
    subject { ability }
    let(:ability) { Ability.new(current_user) }
    let(:visibility) { AccessRight::VISIBILITY_TEXT_VALUE_PRIVATE }
    let(:mock_curation_concern) {
      FactoryGirl.create_curation_concern(:mock_curation_concern, creating_user, { visibility: visibility })
    }
    let(:generic_file) {
      FactoryGirl.create_generic_file(mock_curation_concern, creating_user) { |gf|
        gf.visibility = visibility
      }
    }
    let(:creating_user) { nil }
    let(:current_user) { nil }
    let(:user) { FactoryGirl.create(:user) }
    describe 'without embargo' do
      describe 'creator of object' do
        let(:creating_user) { user }
        let(:current_user) { user }
        it {
          should be_able_to(:create, GenericFile.new)
          should be_able_to(:read, generic_file)
          should be_able_to(:update, generic_file)
          should_not be_able_to(:delete, generic_file)
        }
      end

      describe 'another authenticated user' do
        let(:creating_user) { FactoryGirl.create(:user) }
        let(:current_user) { user }
        it {
          should be_able_to(:create, GenericFile.new)
          should_not be_able_to(:read, generic_file)
          should_not be_able_to(:update, generic_file)
          should_not be_able_to(:delete, generic_file)
        }
      end

      describe 'a nil user' do
        let(:creating_user) { FactoryGirl.create(:user) }
        let(:current_user) { nil }
        it {
          should_not be_able_to(:create, GenericFile.new)
          should_not be_able_to(:read, generic_file)
          should_not be_able_to(:update, generic_file)
          should_not be_able_to(:delete, generic_file)
        }
      end
    end
  end
end
