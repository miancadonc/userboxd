module Findable
  def find_by_name(name)
    all.find{|object| object.name == name}
  end

  def exists?(object)
    !!find_by_name(object)
  end

  def find_or_create_by_name(name)
    !!find_by_name(name) ? find_by_name(name) : new(name)
  end

end
