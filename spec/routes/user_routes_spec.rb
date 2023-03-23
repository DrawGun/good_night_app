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

  describe 'POST /v1/users/:user_id/follow' do
    let(:user_one) { create(:user) }
    let(:user_two) { create(:user) }

    context 'missing parameters' do
      it 'returns an error' do
        post "/v1/users/#{user_one.id}/follow"

        expect(last_response.status).to eq(422)
      end
    end

    context 'valid parameters' do
      let(:followings) do
        {
          followee_id: user_two.id.to_s
        }
      end

      it 'returns correct response' do
        post "/v1/users/#{user_one.id}/follow", followings: followings

        expect(last_response.status).to eq(201)
      end
    end
  end

  describe 'DELETE /v1/users/:user_id/unfollow' do
    let!(:following) { create(:following, follower: follower, followee: followee) }
    let(:follower) { create(:user) }
    let(:followee) { create(:user) }

    context 'missing parameters' do
      it 'returns an error' do
        delete "/v1/users/#{follower.id}/unfollow"

        expect(last_response.status).to eq(422)
      end
    end

    context 'valid parameters' do
      let(:followings) do
        {
          followee_id: followee.id.to_s
        }
      end

      it 'returns correct response' do
        delete "/v1/users/#{follower.id}/unfollow", followings: followings

        expect(last_response.status).to eq(204)
      end
    end
  end

  describe 'GET /v1/users/:user_id/friends' do
    let!(:following) { create(:following, follower: follower, followee: followee) }
    let(:follower) { create(:user) }
    let(:followee) { create(:user) }

    context 'valid parameters' do
      it 'returns correct response' do
        get "/v1/users/#{follower.id}/friends"

        expect(last_response.status).to eq(200)
      end
    end
  end
end
