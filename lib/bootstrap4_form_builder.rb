require 'bootstrap4_form_builder/form_builder'
require 'bootstrap4_form_builder/helper'

module Bootstrap4FormBuilder
  module Rails
    class Engine < ::Rails::Engine
    end
  end
end

ActionView::Base.send :include, Bootstrap4FormBuilder::Helper
ActionView::Base.send :include, Bootstrap4FormBuilder::FormBuilder

