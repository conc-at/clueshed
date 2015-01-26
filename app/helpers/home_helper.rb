module HomeHelper
  def placeholder(type)
    case type
    when 'contrib'
      'What could you talk about?'
    when 'interest'
      'What would you like to hear at this event?'
    end
  end

  def partip(type)
    case type
    when 'contrib'
      Contrib.new
    when 'interest'
      Interest.new
    end
  end
end
