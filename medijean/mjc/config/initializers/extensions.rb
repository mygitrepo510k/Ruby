class ActiveRecord::Base
  # add your instance methods here
  def self.enum_field(field, values)
    raise "hash expected. got #{values}" if !values.is_a? Hash

    self.const_set(field.upcase, values)

    self.send(:define_method, field) { 
      self.class.const_get(field.upcase).key( read_attribute(field.to_sym))
    }

    self.send(:define_method, "#{field}=") { |s|
      if s.to_s.blank?
        value = nil
      else
        constant = self.class.const_get(field.upcase)
        value = constant[s.to_sym]
        raise "invalid value '#{s}' for '#{field.to_sym}'. valid values: #{values.keys}" if value.nil?
      end

      write_attribute(field.to_sym, value)
    }

    self.send(:define_method, "#{field}?") { |s|
      s.to_sym == self.class.const_get(field.upcase).key( read_attribute(field.to_sym))
    }
  end
end