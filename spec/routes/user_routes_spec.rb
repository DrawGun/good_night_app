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

        expect(last_response.status).to eq(200)
      end
    end
  end

  describe 'GET /v1/users/:user_id/sleep_periods' do
    let(:user) { create(:user) }
    let(:user_id) { user.id.to_s }

    before do
      create_list(:sleep_period, 3, user: user)
    end

    context 'invalid parameters' do
      let(:user_id) { (User.last.id + 1000).to_s }

      it 'returns an error' do
        get "/v1/users/#{user_id}/sleep_periods"

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include({
          'detail' => 'Not found'
        })
      end
    end

    context 'valid parameters' do
      it 'returns correct response' do
        get "/v1/users/#{user_id}/sleep_periods"

        expect(last_response.status).to eq(200)
      end
    end
  end
end
