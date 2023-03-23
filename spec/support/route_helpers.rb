module RouteHelpers
  def app
    Application.new
  end

  def response_body
    JSON(last_response.body)
  end
end
