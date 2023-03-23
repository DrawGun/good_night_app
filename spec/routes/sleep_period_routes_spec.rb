RSpec.describe SleepPeriodRoutes, type: :request do
  describe 'POST /v1/sleep_periods' do
    let(:user_id) { create(:user).id.to_s }

    context 'missing parameters' do
      it 'returns an error' do
        post '/v1/sleep_periods'
        binding.pry
        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      let(:sleep_period) do
        {
          fall_asleep: 2.days.ago,
          wake_up: 1.day.ago,
          user_id: nil
        }
      end

      it 'returns an error' do
        post '/v1/sleep_periods', sleep_period: sleep_period

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include({
          'detail' => 'The request does not contain the necessary parameters'
        })
      end
    end

    context 'valid parameters' do
      let(:sleep_period) do
        {
          fall_asleep: 2.days.ago,
          wake_up: 1.day.ago,
          user_id: user_id
        }
      end

      it 'creates a new sleep_period' do
        expect {
          post '/v1/sleep_periods', sleep_period: sleep_period
        }.to change { SleepPeriod.count }.from(0).to(1)

        expect(last_response.status).to eq(201)
      end
    end
  end

  describe 'PUT /:sleep_period_id/wake_up' do
    let(:sleep_period) { create(:sleep_period, wake_up: nil, value: nil) }
    let(:sleep_period_id) { sleep_period.id.to_s }

    context 'missing parameters' do
      it 'returns an error' do
        put "/v1/sleep_periods/#{sleep_period_id}/wake_up"

        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      let(:sleep_period_params) do
        {
          wake_up: nil
        }
      end

      it 'returns an error' do
        put "/v1/sleep_periods/#{sleep_period_id}/wake_up", sleep_period: sleep_period_params

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include({
          'detail' => 'The request does not contain the necessary parameters'
        })
      end
    end

    context 'valid parameters' do
      let(:sleep_period_params) do
        {
          wake_up: 1.day.ago
        }
      end

      it 'shows nil wake_up for existing sleep_period' do
        expect(sleep_period.wake_up).to be_nil
      end

      it 'updates existing sleep_period' do
        put "/v1/sleep_periods/#{sleep_period_id}/wake_up", sleep_period: sleep_period_params

        expect(sleep_period.reload.wake_up).to_not be_nil
        expect(sleep_period.reload.value).to eq(sleep_period.wake_up.to_i - sleep_period.fall_asleep.to_i)
        expect(last_response.status).to eq(200)
      end
    end
  end
end
