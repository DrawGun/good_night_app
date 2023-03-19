Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id, type: :Bignum

      column :name, 'character varying', null: false
    end
  end
end
