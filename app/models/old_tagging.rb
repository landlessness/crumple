class OldTagging < ActiveRecord::Base
  belongs_to :taggable, :polymorphic => true
  belongs_to :tagger,   :polymorphic => true
  belongs_to :old_tag, :foreign_key => "tag_id"
end