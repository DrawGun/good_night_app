Sequel.migration do
  change do
    drop_table(:followers)
  end
end
