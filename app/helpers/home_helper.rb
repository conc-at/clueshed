module HomeHelper
  def placeholder(type)
    case type
      when 'contrib' then 'What could you contribute?'
      when 'interest' then 'What are you intersted in?'
    end
  end

  def partip(type)
    case type
      when 'contrib' then Contrib.new
      when 'interest' then Interest.new
    end
  end
end
