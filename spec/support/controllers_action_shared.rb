shared_examples 'get_index' do
  it 'items size is 10' do
    expect(json_data.size).to eq(10)
  end

  it 'items not to be emty' do
    expect(json_data).not_to be_empty
  end

  it 'returns status code :ok' do
    expect(response).to have_http_status(:ok)
  end
end

shared_examples 'not_found' do |item|
  it 'returns status code :not_found' do
    expect(response).to have_http_status(:not_found)
  end

  it 'returns a not found message' do
    expect(response.body).to match(/Couldn't find #{item}/i)
  end
end

shared_examples 'name_cannot_blank' do
  it 'returns a validation failure message' do
    expect(response.body).to match(/Validation failed: Name can't be blank/i)
  end

  it 'returns status code :unprocessable_entity' do
    expect(response).to have_http_status(:unprocessable_entity)
  end
end

shared_examples 'already_be_taken' do
  it 'returns a validation failure message' do
    expect(response.body).to match(/Validation failed: Name has already been taken/i)
  end
end
