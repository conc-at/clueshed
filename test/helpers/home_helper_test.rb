require 'test_helper'

class HomeHelperTest < ActionView::TestCase
  test 'should return placeholder' do
    assert_equal placeholder('contrib'), 'What could you contribute?'
    assert_equal placeholder('interest'), 'What are you intersted in?'
    assert_equal placeholder(''), nil
  end

  test 'should return instance' do
    assert_instance_of Contrib, partip('contrib')
    assert_instance_of Interest, partip('interest')
  end
end
