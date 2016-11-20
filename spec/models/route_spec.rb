require 'rails_helper'

RSpec.describe Route, type: :model do
  it { is_expected.to validate_presence_of(:data_source) }
  it { is_expected.to validate_presence_of(:start_node) }
  it { is_expected.to validate_presence_of(:end_node) }
  it { is_expected.to validate_presence_of(:start_time) }
  it { is_expected.to validate_presence_of(:end_time) }
  it { is_expected.to validate_inclusion_of(:data_source).in_array(%w(sentinels sniffers loopholes)) }
  it { is_expected.to validate_inclusion_of(:start_node)
                          .in_array(%w(alpha beta gamma delta theta lambda tau psi omega)) }
  it { is_expected.to validate_inclusion_of(:end_node)
                          .in_array(%w(alpha beta gamma delta theta lambda tau psi omega)) }
end
