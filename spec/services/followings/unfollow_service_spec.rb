RSpec.describe Followings::UnfollowService do
  subject { described_class }

  let!(:following) { create(:following, follower: follower, followee: followee) }
  let(:follower) { create(:user) }
  let(:followee) { create(:user) }

  context 'valid parameters' do
    it 'deletes existing Following' do
      expect {
        subject.call(
          follower_id: follower.id,
          followee_id: followee.id
        )
      }.to change { Following.count }.from(1).to(0)
    end
  end

  context 'invalid parameters' do
    it 'adds follower_is_not_found error' do
      result = subject.call(
        follower_id: User.last.id + 1000,
        followee_id: followee.id
      )

      expect(result.success?).to be_falsey
      expect(result.errors).to eq(['Follower is not found'])
    end

    it 'adds followee_is_not_found error' do
      result = subject.call(
        follower_id: follower.id,
        followee_id: User.last.id + 1000
      )

      expect(result.success?).to be_falsey
      expect(result.errors).to eq(['Followee is not found'])
    end

    it 'adds following_is_not_found error' do
      result = subject.call(
        follower_id: follower.id,
        followee_id: follower.id
      )

      expect(result.success?).to be_falsey
      expect(result.errors).to eq(['Following is not found'])
    end
  end
end
