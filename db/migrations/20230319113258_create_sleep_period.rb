Sequel.migration do
  change do
    create_table(:sleep_periods) do
      primary_key :id, type: :Bignum
      foreign_key :user_id, :users, null: false

      column :fall_asleep, 'timestamp(6) without time zone', null: false
      column :wake_up, 'timestamp(6) without time zone'
      column :value, 'integer'

      column :created_at, 'timestamp(6) without time zone', null: false
      column :updated_at, 'timestamp(6) without time zone', null: false
    end
  end
end
