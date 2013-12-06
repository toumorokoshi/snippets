class Maybe
  attr_accessor :value
  attr_accessor :nothing


  def initialize (value)
    @value = value
  end


  def self.bind (method, monad)
    if monad != @nothing
      method.call(monad)
    else
      @nothing
    end
  end

  def self.pack (value)
    return Maybe.new value
  end

  def self.unpack (monad)

    if monad.value != nil
      monad.value
    else
      @nothing
    end

  end

# put it at the end
  @nothing = Maybe.new nil

end

halve = Proc.new do |monad|
  value = monad.value
  if value == 1
    Maybe.nothing
  else
    Maybe.pack(value / 2)
  end
end


puts Maybe.unpack(Maybe.bind(halve, (Maybe.pack 8)))
