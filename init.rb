require 'sortable_columns'
require 'helpers/view_helpers'

ActionController::Base.send(:include, SortableColumns)
ActionView::Base.send(:include, SortableColumns::ViewHelpers)