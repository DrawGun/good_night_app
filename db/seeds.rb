require_relative '../models/ad'

User.destroy_all
User.create([
  { name: 'Bob' },
  { city: 'Joahn' },
  { city: 'Nik' }
])
