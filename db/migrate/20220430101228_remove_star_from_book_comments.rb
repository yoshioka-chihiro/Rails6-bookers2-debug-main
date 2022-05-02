class RemoveStarFromBookComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :book_comments, :rate, :integer
  end
end
