require 'test_helper'

class LayoutHelperTest < ActionView::TestCase
  test 'title' do
    # title('test')
    # assert_equal @show_title, 'test'
  end
  
  test 'show_title' do
    assert !show_title?
  end
  
  test 'stylesheet' do
    # stylesheet
  end
  
  test 'javascript' do
    # javascript
  end
  
end
