class CustomFormBuilder < ActionView::Helpers::FormBuilder
  def check_box(label, *args)
    names = args[0][:saved_values][1]
    _id = names[0]
    _value = names[1]
    _for = "#{@object_name.gsub(/[\[\]]/,'_')}#{_id}"
    _for = _for.gsub('__','_')
    id = @object.send(_id)
    value = @object.send(_value)

    args[0][:checked]=false

    if args[0][:saved_values][0]
      args[0][:saved_values][0].each do |sv|
       args[0][:checked]=true and break if sv.send(_id) == id
      end
    end

    args[0][:saved_values] = nil
    
    super(label, *args )
  end

  def custom_text_field(label, *args, names)
    detail = ""
    if args[0][:saved_values]
      args[0][:saved_values].each do |sv|
        detail = sv.send(label) if @object.send(names[0]) == sv.send(names[0])
      end
    end
    args[0][:saved_values] = nil
    args[0][:value] = detail
    text_field(label, *args)
  end

end
