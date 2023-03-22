RSpec.describe FollowingSerializer do
  subject { described_class.new(following) }

  let(:follower) { create(:user) }
  let(:followee) { create(:user) }
  let(:following) { create(:following, follower: follower, followee: followee) }

  let(:attributes) do
    {
      follower: UserSerializer.new(following.follower).serializable_hash,
      followee: UserSerializer.new(following.followee).serializable_hash
    }
  end

  it 'returns user representation' do
    expect(subject.serializable_hash).to a_hash_including(
      data: {
        id: following.id.to_s,
        type: :following,
        attributes: attributes
      }
    )
  end
end
