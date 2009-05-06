module SortableColumns
  
  def sortable_order(sortable)
    if params[:sort_by] && params[:order]
      check_column(sortable)
      store_sort(sortable)
      return "#{params.delete(:sort_by)} #{params.delete(:order)}"
    else
      return nil
    end
  end
  
private

  def check_column(sortable)
    raise "#{sortable} has no column \"#{params[:sort_by]}\"." unless sortable.column_names.include?(params[:sort_by])
  end

  def store_sort(sortable)
    session[:sortable_columns] ||= Hash.new
    session[:sortable_columns][sortable.to_s.downcase.to_sym] = {params[:sort_by].to_sym => params[:order]}
  end
  
  
  
end
