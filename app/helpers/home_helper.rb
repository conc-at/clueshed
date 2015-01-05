module HomeHelper
  def placeholder(type)
    case type
      when 'contrib' then 'What could you talk about?'
      when 'interest' then 'What would you like to hear at this event?'
    end
  end

  def partip(type)
    case type
      when 'contrib' then Contrib.new
      when 'interest' then Interest.new
    end
  end
end
