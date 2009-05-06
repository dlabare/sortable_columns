module SortableColumns
  
  class ParameterError < StandardError; end
  
  def sortable_order(sortable)
    if params[:sort_by] && params[:order]
      validate_params(sortable)
      store_sort(sortable)
      return "#{params.delete(:sort_by)} #{params.delete(:order)}"
    else
      return nil
    end
  end
  
private

  def validate_params(sortable)
    raise ParameterError.new("#{sortable} has no column \"#{params[:sort_by]}\".") unless sortable.column_names.include?(params[:sort_by])
    raise ParameterError.new("Order must be \"asc\" or \"desc\"") unless params[:order] == "asc" || params[:order] == "desc"
  end

  def store_sort(sortable)
    session[:sortable_columns] ||= Hash.new
    session[:sortable_columns][sortable.to_s.downcase.to_sym] = {params[:sort_by].to_sym => params[:order]}
  end
  
end
