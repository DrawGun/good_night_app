RSpec.describe Users::FindService do
  subject { described_class }

  let!(:user) { create(:user) }

  context 'valid parameters' do
    it 'updates wake_up and value for sleep_period' do
      result = subject.call(id: user.id)

      expect(result.user).to eq(user)
    end
  end

  context 'invalid parameters' do
    it 'returns not_found error' do
      result = subject.call(id: User.last.id + 1000)

      expect(result.success?).to be_falsey
      expect(result.errors).to eq(['Not found'])
    end
  end
end
