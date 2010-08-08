class MoveTagsToNewFormat < ActiveRecord::Migration
  def self.up
    OldTagging.all.each do |t|
      thought = t.taggable
      tag = Tag.find_or_create_by_name t.old_tag.name
      person = thought.person
      person.taggings.create! :thought => thought, :tag => tag
    end
  end

  def self.down
    Tag.delete_all
    Tagging.delete_all
  end
end
