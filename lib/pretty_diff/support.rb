class Object #:nodoc:
  
  def returning(value)
    yield(value)
    value
  end
  
end