module SortableColumns
  
  class ParameterError < StandardError; end
  
  def sortable_order(sortable, options = {})
    if params[:sort_by] && params[:order]
      validate_params(sortable, params)
      store_sort(sortable)
      return "#{params.delete(:sort_by)} #{params.delete(:order)}"
    else
      if session[:sortable_columns] && session[:sortable_columns][sortable.to_s.downcase.to_sym]
        column = session[:sortable_columns][sortable.to_s.downcase.to_sym].keys.first
        return "#{column.to_s} #{session[:sortable_columns][sortable.to_s.downcase.to_sym][column.to_sym]}"
      else
        return options[:default]
      end
    end
  end
  
  def sortable_attributes_and_methods( sortable )
    columns = sortable.column_names
    columns += sortable.sortable_methods.to_a if sortable.respond_to?( :sortable_methods )
    columns.map{ |c| c.to_s }
  end
  
  def validate_params(sortable, params)
    puts "params[:order] = #{params[:order].inspect}\n\nsortable_attributes_and_methods( sortable ) = #{sortable_attributes_and_methods( sortable ).inspect}\n\n"
    raise ParameterError.new("#{sortable} has no column or sortable_method \"#{params[:sort_by]}\". \n\nIf you're trying to sort by an instance method that isn't a column name (e.g. a value from an associated table), you must define \n\n\tsortable_instance_methods :my_method_1, :my_method_2 \n\nin your model class. Don't forget to include it as a column in your query too!") unless SortableColumns.sortable_attributes_and_methods(sortable).include?(params[:sort_by].to_s)
    raise ParameterError.new("Order must be \"asc\" or \"desc\" - you gave #{params[:order]}") unless params[:order].blank? || ["asc","desc"].include?(params[:order].to_s.downcase)
  end
  
  
  def store_params
    @params = params.clone - [ :controller, :action, :authenticity_token, :page, :format, :per_page ]
  end
  
  module_function :sortable_attributes_and_methods, :validate_params
  
private

  def store_sort(sortable)
    session[:sortable_columns] ||= Hash.new
    session[:sortable_columns][sortable.to_s.downcase.to_sym] = {params[:sort_by].to_sym => params[:order]}
  end
  
end
