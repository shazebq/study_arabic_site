class ConditionGenerator
  def bool_generator(attr_list)
    condition_string = ""
    attr_list.form_bool_condition { |s| condition_string += s }
    [condition_string, { value: "true" }]
  end
end

class Array
  def form_bool_condition
    attribute_list = ["online", "in_person"] & self
    attribute_list.each_with_index do |attribute, index|
      if self.include?(attribute) # check of it was a selected or checked attribute
        yield("#{attribute} = :value")
        yield(" OR ") unless index == attribute_list.length - 1 # unless it's the last in the list in which case you don't need the OR
      end
    end
  end
end

# comments
