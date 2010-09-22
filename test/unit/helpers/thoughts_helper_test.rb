require 'test_helper'

class ThoughtsHelperTest < ActionView::TestCase
  test 'link_to_state_events(thought, options)' do
    assert_match /archive/, link_to_state_events(Thought.first,{})
  end
  test 'link_to_new_thought' do
    assert_match /new thought/, link_to_new_thought
    assert_match /new thought about Crumple/, link_to_new_thought(Project.first)
  end
  test 'link_to_tag' do
    assert_match /foo/, link_to_tag(Tag.first,'link',Project.first)
  end
  test 'links_to_tags' do
    assert_match /foo/, links_to_tags(Tag.all,Project.first)
  end
  test 'link_to_pinky_img(url)' do
    assert_match /google.com/, link_to_pinky_img('http://www.google.com')
  end
end
