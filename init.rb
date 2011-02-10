require 'sortable_columns'
require 'helpers/view_helpers'
require 'helpers/active_record_base_methods'

ActionController::Base.send(:include, SortableColumns)
# allow sort_params to preserve existing params 
# (minus standard params like  :controller, :action, etc )
ApplicationController.send( :append_before_filter, :store_params)

ActionView::Base.send(:include, SortableColumns::ViewHelpers)
ActiveRecord::Base.send(:extend, SortableColumns::ActiveRecordBaseMethods)