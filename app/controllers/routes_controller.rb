class RoutesController < ApplicationController
  params do
    validates :source, presence: true, inclusion: %w(sentinels sniffers loopholes)
  end
  def index
    @routes = Route.where(data_source: params[:source])
    render json: @routes, each_serializer: RouteSerializer, root: :routes
  end

  params do
    validates :passphrase, inclusion: ['Kans4s-i$-g01ng-by3-bye']
    validates :source, :start_node, :end_node, :start_time, :end_time, presence: true
    validates :source, inclusion: %w(sentinels sniffers loopholes)
    validates :start_node, :end_node, inclusion: %w(alpha beta gamma delta theta lambda tau psi omega)
    validates :start_time, :end_time, format: { with: /\A[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}\z/ }
  end
  # end time should be > start time
  def create
    Route.create!(
      data_source: params[:source],
      start_node: params[:start_node],
      end_node: params[:end_node],
      start_time: params[:start_time],
      end_time: params[:end_time]
    )
    head :no_content
  end
end
