class ConditionGenerator
  def bool_generator(attr_list)
    condition_string = ""
    attr_list.form_bool_condition { |s| condition_string += s }
    condition_string
  end
end

class Array
  def form_bool_condition
    self.each_with_index do |attribute, index|
      yield("#{attribute} = true")
      yield(" OR ") unless index == (self.length - 1)
    end
  end
end
