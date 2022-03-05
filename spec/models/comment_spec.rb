require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "#create" do
    before do
      @comment = FactoryBot.build(:comment)
    end
  end
end
