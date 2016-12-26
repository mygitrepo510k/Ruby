require 'spec_helper'

describe Dosage do
  it { should validate_presence_of(:frequency) }
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:unit) }
end
