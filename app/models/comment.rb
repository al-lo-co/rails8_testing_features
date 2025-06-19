class Comment < ApplicationRecord
  belongs_to :product
  after_create :broadcast_message


  def broadcast_message
    broadcast_append_to(
      [ product, "comments" ],
      target: "comments",
      partial: "comments/comment",
      locals: { product: self }
    )
  end
end
