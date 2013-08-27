module SortableColumns
  
  module ViewHelpers

    def sort_params(sortable, column, opts = {})
      raise ParameterError.new("Please provide a Class as your first param. Ex: sort_param(User, :created_at)") unless sortable.is_a?(Class)
      raise ParameterError.new("#{sortable} has no column \"#{column}\".") unless sortable.column_names.include?(column.to_s) || opts[:skip_column_validation]
      
      init_session unless session[:sortable_columns]
      return_params = params.dup.except('action', 'controller')
      
      if session[:sortable_columns][sortable.to_s.downcase]
        if session[:sortable_columns][sortable.to_s.downcase][column] == "asc"
          return return_params.merge(:sort_by => column.to_s, :order => 'desc')
        else
          return return_params.merge(:sort_by => column.to_s, :order => 'asc')
        end
      end
      
      # default
      return return_params.merge(:sort_by => column.to_s, :order => 'desc')
    end
  
  private
    
    def init_session
      session[:sortable_columns] = Hash.new
    end
    
  end
  
end