require 'helpers/view_helpers'

module SortableColumns
  
  class ParameterError < StandardError; end
  
  def sortable_order(sortable, options = {})
    if params[:sort_by] && params[:order] && !params[:sort_by].blank? && !params[:order].blank?
      validate_params(sortable, options)
      store_sort(sortable)
      return "#{params.dup.delete(:sort_by)} #{params.dup.delete(:order)}"
    elsif options[:use_session]
      if session[:sortable_columns] && session[:sortable_columns][sortable.to_s.downcase.to_sym]
        column = session[:sortable_columns][sortable.to_s.downcase.to_sym].keys.first
        return "#{column.to_s} #{session[:sortable_columns][sortable.to_s.downcase.to_sym][column.to_sym]}"
      else
        return options[:default]
      end
    else
      return options[:default]
    end
  end
  
private

  def validate_params(sortable, options)
    raise ParameterError.new("#{sortable} has no column \"#{params[:sort_by]}\".") unless sortable.column_names.include?(params[:sort_by]) || options[:skip_column_validation]
    raise ParameterError.new("Order must be \"asc\" or \"desc\"") unless params[:order] == "asc" || params[:order] == "desc"
  end

  def store_sort(sortable)
    session[:sortable_columns] ||= Hash.new
    session[:sortable_columns][sortable.to_s.downcase.to_sym] = {params[:sort_by].to_sym => params[:order]}
  end
  
end

ActionController::Base.send(:include, SortableColumns)
ActionView::Base.send(:include, SortableColumns::ViewHelpers)