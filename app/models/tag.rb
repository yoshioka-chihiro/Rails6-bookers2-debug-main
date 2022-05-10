class Tag < ApplicationRecord
   # book_tagsはtag_idから選べ！的な制約
  has_many :tag_relationships, dependent: :destroy, foreign_key: 'tag_id'
  has_many :books, through: :tag_relationships

  validates :name, uniqueness: true, presence: true
  
  scope :merge_books, -> (tags){ }
  
  def self.search_books_for(content, method)
    
    if method == 'perfect'
      tags = Tag.where(name: content)
    elsif method == 'forward'
      tags = Tag.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      tags = Tag.where('name LIKE ?', '%' + content)
    else
      tags = Tag.where('name LIKE ?', '%' + content + '%')
    end
    
    return tags.inject(init = []) {|result, tag| result + tag.books}
    
  end
end
