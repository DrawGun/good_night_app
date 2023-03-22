class FollowingSerializer
  include FastJsonapi::ObjectSerializer

  attributes :follower do |object|
    UserSerializer.new(object.follower).serializable_hash
  end

  attributes :followee do |object|
    UserSerializer.new(object.followee).serializable_hash
  end
end
