require 'test_helper'

class DropBoxesHelperTest < ActionView::TestCase
  test 'vcf path' do
    assert_equal '/drop_box/crumple.vcf', drop_box_vcf_path
  end
end
