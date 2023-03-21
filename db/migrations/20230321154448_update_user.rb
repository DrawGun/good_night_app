Sequel.migration do
  change do
    add_column :users, :created_at, 'timestamp(6) without time zone', null: false
    add_column :users, :updated_at, 'timestamp(6) without time zone', null: false
  end
end
