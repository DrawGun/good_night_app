Sequel.migration do
  change do
    create_table(:followings) do
      primary_key :id, type: :Bignum
      foreign_key :follower_id, :users, null: false
      foreign_key :followee_id, :users, null: false

      column :created_at, 'timestamp(6) without time zone', null: false
      column :updated_at, 'timestamp(6) without time zone', null: false

      index [:follower_id, :followee_id], unique: true
    end
  end
end
