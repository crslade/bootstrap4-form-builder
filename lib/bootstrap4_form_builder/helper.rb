module Bootstrap4FormBuilder
  module Helper
    
    def bootstrap_form_for(object, options= {}, &block)
      options.reverse_merge!({builder: Bootstrap4FormBuilder::FormBuilder::BootstrapBuilder})
      
      options[:html] ||= {}
      options[:html][:role] ||= "form"
      
      form_for(object, options, &block)
    end
    
    
    def temporarily_disable_field_error_proc
      original_proc = ActionView::Base.field_error_proc
      ActionView::Base.field_error_proc = proc { |input, instance| input }
      yield
    ensure
      ActionView::Base.field_error_proc = original_proc
    end
    
  end
end