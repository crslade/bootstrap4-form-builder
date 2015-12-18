module Bootstrap4FormBuilder
  module FormBuilder
    class BootstrapBuilder < ActionView::Helpers::FormBuilder
    
      delegate :content_tag, :concat, :capture, to: :@template
    
      attr_reader :layout, :label_col, :control_col
    
      FIELD_HELPERS = %w{color_field date_field datetime_field datetime_local_field
          email_field month_field number_field password_field phone_field
          range_field search_field telephone_field text_area text_field time_field
          url_field week_field}
    
      def initialize(object_name, object, template, options)
        @layout = options[:layout]
        @label_col = options[:label_col]
        @control_col = options[:control_col]
        @inline_errors = options[:inline_errors].nil? ? true : options[:inline_errors]
        @inline_error_class = options[:inline_error_class]
        #puts "Inline Errors: #{@inline_errors}"
        #Could be done in helper.
        if inline_layout?
          options.reverse_merge! html: {}
          options[:html][:class] = [options[:html][:class], inline_class].compact.join(" ")
        end
    
        super
      end
    
      FIELD_HELPERS.each do |method_name|
        define_method(method_name) do |method, *args|
          options = args.extract_options!.symbolize_keys!
          standard_html("#{__method__.to_s}", method, options)
        end
      end
    
      def standard_html(type, method, options = {})
        form_group_builder(method, options) do
          content = []
          options[:class] = [control_class, options[:class]].compact.join(" ")
          
          
          temporarily_disable_field_error_proc do
            content << generate_label(method, options)
            if gridded_form?
              content << content_tag(:div, class: @control_col) do
                @template.send(type, object_name, method, options)
              end
            else
              content << @template.send(type, object_name, method, options)
            end
          end
          content << generate_error_help(method, options)
          content.compact.join.html_safe
        end
      end
  
      def check_box(name, options = {}, checked_value = "1", unchecked_value = "0", &block)
        options = options.symbolize_keys!
        check_box_options = options.except(:label, :label_class, :inline)
        label_class = [options[:label_class]]
        
        temporarily_disable_field_error_proc do
          html = super(name, check_box_options, checked_value, unchecked_value)
          label_content = block_given? ? capture(&block) : options[:label]
          html.concat(" ").concat(label_content || (object && object.class.human_attribute_name(name)) || name.to_s.humanize)

          label_name = name
  
          label_class = options[:label_class] 
  
          if options[:inline]
            label_class = ["checkbox-inline", label_class].compact.join(' ')
            label(label_name, html, class: label_class)
          else
            content_tag(:div, class: "checkbox") do
              label(label_name, html, class: label_class)
            end
          end
        end
      end
  
      def radio_button(name, value, *args)
        options = args.extract_options!.symbolize_keys!
        args << options.except(:label, :label_class, :inline)
        label_class = [options[:label_class]]
        
        temporarily_disable_field_error_proc do
          html = super(name, value, *args) + " " + value.humanize

          if options[:inline]
            label_class = ["radio-inline", label_class].compact.join(" ")
            label(value, html, value: value, class: label_class)
          else
            content_tag(:div, class: "radio") do
              label(value, html, value: value, class: label_class)
            end
          end
        end
      end
    
      def form_group(*args, &block)
        options = args.extract_options!
        name = args.first
    
        options[:class] = ["form-group", options[:class]]
        options[:class] << label_error_class if has_errors?(name)
        options[:class] = options[:class].compact.join(" ")
    
        content_tag(:div, options.except(:label, :label_class)) do
          label_class = [@label_col, options[:label_class]].compact.join(' ')
          
          label = @template.label_tag(nil, options[:label], class: label_class) if options[:label]
          controls = capture(&block).to_s
      
          error_help = generate_error_help(name)
          controls = content_tag(:div, class: @control_col) { concat(controls) } if gridded_form?
      

          concat(label).concat(controls).concat(error_help)
        end
      end
    
      def submit(name = nil, options = {})
        options[:class] = ["btn btn-default", options[:class]].compact.join(" ")
        super(name, options)
      end
  
      def primary(name = nil, options = {})
        options[:class] = ["btn btn-primary", options[:class]].compact.join(" ")
        method(:submit).super_method.call(name, options)
      end
  
      def alert_message(title, options = {})
        alert_class = options[:class] || 'alert alert-danger'
        display_errors = options.delete(:error_summary)
    
        if object.respond_to?(:errors) && object.errors.full_messages.any?
          content_tag :div, class: alert_class do
            content = [content_tag(:p, title)]
            content << error_summary if display_errors
            content.join.html_safe
          end
        end
      end
  
      def error_summary
        content_tag :ul, class: 'bootstrap-form-error-summary' do
          object.errors.full_messages.each do |error|
            concat content_tag(:li, error)
          end
        end
      end
    
      private
  
      def objectify_options(options)
        super.except(:layout, :inline_errors, :inline_error_class)
      end
  
      def temporarily_disable_field_error_proc
        original_proc = ActionView::Base.field_error_proc
        ActionView::Base.field_error_proc = proc { |input, instance| input }
        yield
      ensure
        ActionView::Base.field_error_proc = original_proc
      end
  
      def form_group_builder(method, options)
        container_class = [fieldset_class]
        container_class << "row" if gridded_form?
        container_class << fieldset_errors_class if has_errors?(method)
        container_class << options.delete(:container_class)
        container_class = container_class.compact.join(" ")
    
        content_tag :div, class: container_class do
          yield
        end
      end
  
      def generate_label(name, *args)
        options = args.extract_options!
        label_class = options.delete(:label_class)
        label_class = [@label_col, label_class]
        label_class << "form-control-label" if gridded_form?
        label_class << hide_label_class if hide_label?(options)
        label_class << label_error_class if has_errors?(name)
        label_class = label_class.compact.join(" ")
    
        label_name  = options.delete(:label)
        label_name ||= name.to_s.humanize
    
        label(name, label_name, class: label_class)    
      end
  
      def generate_error_help(name, *args)
        if has_errors?(name) && @inline_errors
          error_class = ["text-muted", "error-text", @inline_error_class].compact.join(" ")
          content_tag(:small, class: error_class) do
            get_error_messages(name)
          end
        end
      end
  
      def gridded_form?
        @label_col && @control_col
      end
  
      def inline_layout?
        @layout == :inline
      end
  
      def hide_label?(options)
        options.delete(:hide_label)
      end
  
      #Errors
  
      def has_errors?(name)
        object.respond_to?(:errors) && !(name.nil? || object.errors[name].empty?)
      end
  
      def get_error_messages(name)
        object.errors[name].join(", ")
      end
  
      #Default classes
  
      def hide_label_class
        "sr-only"
      end
  
      def inline_class
        "form-inline"
      end
  
      def control_class
        "form-control"
      end
  
      def fieldset_class
        "form-group"
      end
  
      def label_error_class
        "label-error"
      end
  
      def fieldset_errors_class
        "field-with-errors"
      end
    
    end
  end
end