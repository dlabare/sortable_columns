module SortableColumns
  
  module ActiveRecordBaseMethods
    attr_accessor :sortable_methods
    
    def sortable_instance_methods(methods)
      @sortable_methods = methods.to_a
    end
  end
end