module Enumerable
  def my_each
    if block_given?
        for i in 0...self.size
          yield(self[i])
        end
    end
    return self
  end

  def my_each_with_index
    if block_given?
       for i in 0...self.size
          yield(self[i], i)
        end
    end
    return self
  end

  def my_select
    result = []
    if block_given?
      self.my_each {|x| result<<x if yield x}
    end
    return result
  end

  def my_all?
    if block_given?
      self.my_each {|x| return false if yield(x) == false}
      return true
    else
      self.my_each {|x| return false if x == nil || false}
      return true
    end
  end

  def my_any?
    if block_given?
      self.my_each {|x| return true if yield(x) == true}
    end
    return false
  end

  def my_none?
    if block_given?
      self.my_each {|x| return false if yield(x) == true}
    end
    return true
  end

  def my_count
    count = 0
    if block_given?
      self.my_each {|x| count +=1 if yield(x)}
    else
      self.my_each {|x| count +=1}
    end
    return count
  end

  def my_map
    result = []
    if block_given?
      self.my_each {|x| result << yield(x)}
      return result
    else
      self.to_enum(:my_map)
    end
  end

  def my_map_with_proc (proc = nil)
      result = []
      if proc != nil && proc.is_a?(Proc)
         self.my_each {|x| result << proc.call(x)}
         return result
      else
        return self.to_enum
      end
  end

  def my_map_with_proc_or_block (proc = nil)
    result = []
    if proc != nil && proc.is_a?(Proc)
       self.my_each {|x| result << proc.call(x)}
       return result
    elsif block_given?
      self.my_each {|x| result << yield(x)}
      return result
    else
      return self.to_enum
    end


  end

  def my_inject(running_result = self.shift)
    for x in self
      running_result = yield(running_result, x)
    end
    return running_result
  end
  #shift => removes the first element of self and returns it
  #(shifting all other elements down by one).
  #Returns nil if the array is empty.

  def multiply_els(array)
    array.my_inject {|result, x| result * x}
  end

end

#Test
array = [5,2,10,8]
#array.each {|x| puts "Value: #{x}"}
#array.my_each {|x| puts "Value: #{x}"}

#array.each_with_index {|value, index| puts "#{index}: #{value}"}
#array.my_each_with_index {|value, index| puts "#{index}: #{value}"}

#puts array.select {|x| x > 5}
#puts array.my_select {|x| x > 5}

#puts array.all? {|x| x > 5}
#puts array.my_all? {|x| x > 5}

#puts array.any? {|x| x > 5}
#puts array.my_any? {|x| x > 5}

#puts array.none? {|x| x > 5}
#puts array.my_none? {|x| x > 5}

#puts array.count {|x| x > 5}
#puts array.my_count {|x| x > 5}

#puts array.map {|x| x**2}
#puts array.my_map {|x| x**2}

#my_proc = Proc.new {|x| x**2}
#puts array.my_map_with_proc(my_proc)
#puts array.my_map_with_proc

#puts array.my_map_with_proc_or_block(my_proc)
#puts array.my_map_with_proc_or_block {|x| x**2}


#puts array.inject (0) {|running_total, item| running_total + item}
#puts array.my_inject (0) {|running_total, item| running_total + item}

#multiply_els([2,4,5]) #=>40
#[2,4,5].multiply_els(1)
