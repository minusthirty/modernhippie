["photos", "food", "everyday"].each do |name|
  Category.create(:name => name)
end