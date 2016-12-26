YARD::Templates::Engine.register_template_path(File.dirname(__FILE__) + '/templates')
YARD::Tags::Library.define_tag("Wireframe", :wireframe)
YARD::Tags::Library.define_tag("Renders", :renders)

class ValidatesPresenceOfHandler < YARD::Handlers::Ruby::Base
  handles method_call(:validates_presence_of)
  namespace_only

  def process
    required_fields = []
    statement.parameters.each do |param|
      if param.class != FalseClass
        name = param.jump(:tstring_content, :ident).source
       
        object = find_or_create_method(name)

        required_fields << name

        # puts "#{object.class} #{object.object_id}"
        
        object[:validation] ||= {}
        object[:validation][:required] = true
      end
    end

    class_object = find_or_create_class
    puts "#{class_object.class} #{class_object.object_id}"
    class_object[:validation] ||= {}
    class_object[:validation][:required_fields] ||= []
    class_object[:validation][:required_fields] = class_object[:validation][:required_fields].concat(required_fields)
  end

  def find_or_create_class
    object = YARD::Registry.all(:class).find { |model|
      "#{model.namespace}" == "#{namespace}"
    }

    if object.nil?
      puts "creating #{namespace}"
      object = YARD::CodeObjects::ClassObject.new(:root, namespace.to_s.to_sym)
      register(object)
    end

    object
  end

  def find_or_create_method(name)
    object = YARD::Registry.all(:method).find { |model|
      "#{model.namespace}##{model.name}" == "#{namespace}##{name}"
    }

    if object.nil?
      puts "creating #{namespace}##{name}"
      object = YARD::CodeObjects::MethodObject.new(namespace, name)
      register(object)
    end

    object
  end
end