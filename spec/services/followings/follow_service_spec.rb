RSpec.describe Followings::FollowService do
  subject { described_class }

  let!(:user) { create(:user) }
  let!(:followee) { create(:user) }

  context 'valid parameters' do
    it 'creates new Following' do
      expect {
        subject.call(
          follower_id: user.id,
          followee_id: followee.id
        )
      }.to change { Following.count }.from(0).to(1)
    end

    it 'assigns sleep_period' do
      result = subject.call(
        follower_id: user.id,
        followee_id: followee.id
      )

      expect(result.following).to be_kind_of(Following)
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
        follower_id: user.id,
        followee_id: User.last.id + 1000
      )

      expect(result.success?).to be_falsey
      expect(result.errors).to eq(['Followee is not found'])
    end

    it 'adds can_not_be_same_as_follower error' do
      result = subject.call(
        follower_id: user.id,
        followee_id: user.id
      )

      expect(result.success?).to be_falsey
      expect(result.errors).to eq([{ followee_id: ['Can not be same as the follower'] }])
    end

    it 'adds validates_unique error' do
      create(:following, follower: user, followee: followee)

      result = subject.call(
        follower_id: user.id,
        followee_id: followee.id
      )

      expect(result.success?).to be_falsey
      expect(result.errors).to eq([{ [:follower_id, :followee_id] => ['is already taken'] }])
    end
  end
end
