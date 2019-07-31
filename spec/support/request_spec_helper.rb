module RequestSpecHelper
  def json
    json_data['attributes']
  end

  def json_data
    JSON.parse(response.body)['data']
  end
end
