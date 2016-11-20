require 'rails_helper'

RSpec.describe RouteSerializer, type: :serializer do
  subject { RouteSerializer.new(FactoryGirl.build(:route)) }

  def json
    JSON.parse(subject.to_json).with_indifferent_access
  end

  it { expect(json.keys.map(&:to_sym)).to contain_exactly(:source, :start_node, :end_node, :start_time, :end_time) }

  it 'returns start_time & end_time in proper format' do
    expect(json[:start_time]).to match(/\A[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}\z/)
    expect(json[:end_time]).to match(/\A[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}\z/)
  end
end
