require 'rails_helper'

describe Question do

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

  context "Assosiations" do
    it { should have_many(:answers).dependent(:destroy) }
  end
end
