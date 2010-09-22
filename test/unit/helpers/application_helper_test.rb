require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'display text' do
    link = 'http://www.google.com'
    text = 'click this ' + link
    assert_equal "click this <a class=\"auto-link\" href=\"http://www.google.com\">http://www.google.com</a>", display_text(text)
    display_text(text) {|l| assert_equal link, l}
  end
  
  test 'display text store links' do
    link1 = 'http://www.google.com'
    link2 = 'http://www.flickr.com'
    text = 'click this ' + link1 + ' ' + link2
    thought = Thought.new :body => text
    urls = []
    display_text_store_links(thought, urls)
    assert_equal 2, urls.size
  end
  
  test "page entries info" do
    @projects = Project.order('upper(name)').paginate(:page => 1, :per_page => Project.per_page)
    assert_equal '2 projects', page_entries_info(@projects, :entry_name => t(:project))
  end
end