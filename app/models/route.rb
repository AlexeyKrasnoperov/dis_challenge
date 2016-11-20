class Route < ApplicationRecord
  ACCEPTABLE_SOURCES = %w(sentinels sniffers loopholes).freeze
  ACCEPTABLE_NODES = %w(alpha beta gamma delta theta lambda tau psi omega).freeze

  validates :data_source, :start_node, :end_node, :start_time, :end_time, presence: true
  validates :data_source, inclusion: { in: ACCEPTABLE_SOURCES }
  validates :start_node, :end_node, inclusion: { in: ACCEPTABLE_NODES }
end
