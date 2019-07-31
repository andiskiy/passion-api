# frozen_string_literal: true

module Response
  def json_response(obj, status = :ok)
    render json: obj, status: status
  end
end
