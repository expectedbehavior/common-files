class Array
  # will allow stuff like foo.bars.map(&[:x, :y, :z])
  def to_proc
    Proc.new do |obj, *args|
      self.map { |method| obj.send(method) }
    end
  end
end
