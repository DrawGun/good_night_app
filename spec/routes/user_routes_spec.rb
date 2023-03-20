RSpec.describe UserRoutes, type: :request do
  describe 'GET /v1/users/:user_id' do
    let!(:user) { create(:user) }
    let(:user_id) { user.id.to_s }

    context 'invalid parameters' do
      let(:user_id) { (User.last.id + 1000).to_s }

      it 'returns an error' do
        get "/v1/users/#{user_id}"

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include({
          'detail' => 'Not found'
        })
      end
    end

    context 'valid parameters' do
      it 'returns correct response' do
        get "/v1/users/#{user_id}"

        expect(last_response.status).to eq(201)
      end
    end
  end
end
