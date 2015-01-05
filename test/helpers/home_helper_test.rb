require 'test_helper'

class HomeHelperTest < ActionView::TestCase
  test 'should return placeholder' do
    assert_equal placeholder('contrib'), 'What could you talk about?'
    assert_equal placeholder('interest'), 'What would you like to hear at this event?'
    assert_equal placeholder(''), nil
  end

  test 'should return instance' do
    assert_instance_of Contrib, partip('contrib')
    assert_instance_of Interest, partip('interest')
  end
end
