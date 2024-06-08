class Post < ApplicationRecord
  MAX_TITLE_LENGTH = 125

  validates :title, presence: true, length: { maximum: MAX_TITLE_LENGTH }

  validates :description, presence: true
  validates :upvotes,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 0
            }
  validates :downvotes,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 0
            }
  validates_inclusion_of :is_blog_worthy, in: [true, false]

  validate :net_votes_not_negative

  private

  # Custom validation to ensure net votes (upvotes - downvotes) are not negative
  def net_votes_not_negative
    errors.add(:base, "Net votes cannot be negative") if upvotes - downvotes < 0
  end
end
