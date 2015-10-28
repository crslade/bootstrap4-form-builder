module Bootstrap4FormBuilder
  module Helper
    
    def bootstrap_form_for(object, options= {}, &block)
      options.reverse_merge!({builder: Bootstrap4FormBuilder::FormBuilder::BootstrapBuilder})
      
      options[:html] ||= {}
      options[:html][:role] ||= "form"
      
      #Done in Builder
      # if options[:layout] == :inline
      #   options[:html][:class] = [options[:html][:class], "form-inline"].compact.join(" ")
      # end
      
      #Done in Builder
      #temporarily_disable_field_error_proc do
        form_for(object, options, &block)
      #end
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