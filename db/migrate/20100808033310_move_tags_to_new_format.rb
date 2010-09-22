class MoveTagsToNewFormat < ActiveRecord::Migration
  def self.up
    if Object.const_defined? :OldTagging
      OldTagging.all.each do |t|
        thought = t.taggable
        tag = Tag.find_or_create_by_name t.old_tag.name
        person = thought.person
        person.taggings.create! :thought => thought, :tag => tag
      end
    end
  end

  def self.down
    Tag.delete_all
    Tagging.delete_all
  end
end
