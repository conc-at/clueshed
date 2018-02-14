require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'should return correct bootstrap flash class' do
    assert_equal flash_class('notice'), 'alert-info'
    assert_equal flash_class('success'), 'alert-success'
    assert_equal flash_class('error'), 'alert-danger'
    assert_equal flash_class('alert'), 'alert-warning'
    assert_nil flash_class('')
  end
end
