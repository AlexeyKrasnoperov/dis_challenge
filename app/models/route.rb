class Route < ApplicationRecord
  validates_presence_of :source, :start_node, :end_node, :start_time, :end_time
  validates_inclusion_of :source, in: %w(sentinels, sniffers, loopholes)
  validates_inclusion_of :start_node, :end_node, in: %w(alpha, beta, gamma, delta, theta, lambda, tau, psi, omega)
end
