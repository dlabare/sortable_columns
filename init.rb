require 'sortable_columns'
require 'helpers/view_helpers'
require 'helpers/active_record_base_methods'

ActionController::Base.send(:include, SortableColumns)
ActionView::Base.send(:include, SortableColumns::ViewHelpers)
ActiveRecord::Base.send(:extend, SortableColumns::ActiveRecordBaseMethods)