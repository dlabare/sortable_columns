module SortableColumns
  
  module ViewHelpers

    def sort_params(sortable, column)
      raise ParameterError.new("Please provide a Class as your first param. Ex: sort_param(User, :created_at)") unless sortable.is_a?(Class)
      raise ParameterError.new("#{sortable} has no column \"#{column}\".") unless sortable.column_names.include?(column.to_s)
      
      init_session unless session[:sortable_columns]
      
      if session[:sortable_columns][sortable.to_s.downcase.to_sym]
        if session[:sortable_columns][sortable.to_s.downcase.to_sym][column.to_sym] == "asc"
          return { :sort_by => column.to_s, :order => 'desc' }
        else
          return { :sort_by => column.to_s, :order => 'asc' }  
        end
      end
      
      # default
      return { :sort_by => column.to_s, :order => 'desc' }
    end
  
  private
    
    def init_session
      session[:sortable_columns] = Hash.new
    end
    
  end
  
end