Sequel.migration do
  change do
    add_index :sleep_periods, :user_id
  end
end
