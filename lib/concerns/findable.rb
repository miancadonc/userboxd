module Findable
  def find_by_name(name)
    all.find{|user| user.name == name}
  end

  def exists?(object)
    !!find_by_name(object)
  end

end
