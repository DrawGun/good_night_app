RSpec.describe UserSerializer do
  subject { described_class.new(user) }

  let(:user) { create(:user) }

  let(:attributes) do
    {
      name: user.name
    }
  end

  it 'returns user representation' do
    expect(subject.serializable_hash).to a_hash_including(
      data: {
        id: user.id.to_s,
        type: :user,
        attributes: attributes
      }
    )
  end
end
