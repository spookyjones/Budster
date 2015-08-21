class AddAttachmentImageToReplies < ActiveRecord::Migration
  def self.up
    change_table :replies do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :replies, :image
  end
end
