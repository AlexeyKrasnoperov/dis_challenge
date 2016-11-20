class Route < ApplicationRecord
  validates :data_source, :start_node, :end_node, :start_time, :end_time, presence: true
  validates :data_source, inclusion: { in: %w(sentinels sniffers loopholes) }
  validates :start_node, :end_node, inclusion: { in: %w(alpha beta gamma delta theta lambda tau psi omega) }
end
