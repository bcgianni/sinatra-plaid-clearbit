require 'pry'

module ApiHelper
  def with_checked_body(request_body)
    request_body.rewind # in case someone already read it
    body = request_body.read
    unless body.blank?
      yield JSON.parse(body)
      return true
    end
    false
  end
end
