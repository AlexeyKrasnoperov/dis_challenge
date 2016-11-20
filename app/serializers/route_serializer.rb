class RouteSerializer < ActiveModel::Serializer
  attributes :source, :start_node, :end_node, :start_time, :end_time

  def source
    object.data_source
  end

  def start_time
    format_time(object.start_time)
  end

  def end_time
    format_time(object.end_time)
  end

  private

  def format_time(time)
    time.iso8601.delete('Z')
  end
end
