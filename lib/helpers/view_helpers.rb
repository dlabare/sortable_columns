module SortableColumns
  
  module ViewHelpers

    def sort_params(sortable, column)
      SortableColumns.validate_params(sortable, :sort_by=>column)
      init_session unless session[:sortable_columns]
      
      if session[:sortable_columns][sortable.to_s.downcase.to_sym]
        if session[:sortable_columns][sortable.to_s.downcase.to_sym][column.to_sym] == "asc"
          return params.merge( { :sort_by => column.to_s, :order => 'desc' } )
        else
          return params.merge( { :sort_by => column.to_s, :order => 'asc' }  )
        end
      end
      
      # default
      return params.merge( { :sort_by => column.to_s, :order => 'desc' } )
    end
  
  private
    
    def init_session
      session[:sortable_columns] = Hash.new
    end
    
  end
  
end