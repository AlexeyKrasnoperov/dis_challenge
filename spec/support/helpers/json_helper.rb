module JsonHelper
  def json
    @json ||= JSON.parse(response.body)
  rescue JSON::ParserError
    pp response.body
    raise
  end
end
