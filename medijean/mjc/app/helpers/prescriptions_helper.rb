module PrescriptionsHelper

  def capitalize_array(array)
    array.map {|v| [v.capitalize,v]}
  end

  def sort_except_other(array)
    other = array.delete("Other")
    array = array.sort
    array << "Other"
    array.map {|v| [v,v]}
  end
end
