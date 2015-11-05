[![Build Status](https://travis-ci.org/crslade/bootstrap4-form-builder.svg?branch=master)](https://travis-ci.org/crslade/bootstrap4-form-builder.svg?branch=master)
# Rails Bootstrap Form Builder 

**Rails Bootstrap Form Builder** is a rails form builder that makes it easy to create Bootstrap 4+ forms into your rails application.

## Requirements

* Ruby 2.1+
* Rails 4.0+
* Bootstrap 4.0+ (In Alpha)

## Installation

Add it to your Gemfile:

`gem 'bootstrap4_form_builder'`

Then:

`bundle`

## Usage

To get started, just tell your form to use the `BootstrapFormBuilder`. Here's an example:

```erb
<%= form_for @user, builder: Bootstrap4FormBuilder::FormBuilder::BootstrapBuilder do |f| %>
	<%= f.text_field :name %>
	<%= f.email_field :email %>
	<%= f.password_field :password %>
	<%= f.password_field :password_confirmation %>
	<%= f.submit %>
<% end%>
```

This will generate the following HTML:

```HTML
<form class="new_user" id="new_user" action="/users" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" />
	<div class="form-group">
		<label class="form-control-label" for="user_name">Name</label>
		<input class="form-control" type="text" name="user[name]" id="user_name" />
	</div>
	<div class="form-group">
		<label class="form-control-label" for="user_email">Email</label>
		<input class="form-control" type="email" name="user[email]" id="user_email" />
	</div>
	<div class="form-group">
		<label class="form-control-label" for="user_password">Password</label><input class="form-control" type="password" name="user[password]" id="user_password" />
	</div>
	<div class="form-group">
		<label class="form-control-label" for="user_password_confirmation">Password confirmation</label>
		<input class="form-control" type="password" name="user[password_confirmation]" id="user_password_confirmation" />
	</div>
	<input type="submit" name="commit" value="Create User" class="btn btn-default" />
</form>
```


Or make BootstrapFormBuilder the default form builder by including the following in `config/application.rb`:

```ruby
ActionView::Base.default_form_builder = "Bootstrap4FormBuilder::FormBuilder::BootstrapBuilder"
``` 

Or just use the bootstrap_form_for helper method:

```erb
<%= bootstrap_form_for @user do |f| %>
	<%= f.text_field :name %>
	<%= f.email_field :email %>
	<%= f.password_field :password %>
	<%= f.password_field :password_confirmation %>
	<%= f.submit %>
<% end%>
```

### bootstrap_form_tag

On the todo list.

## Form Helpers

This gem wraps the following Rails form helpers:

* color_field 
* date_field 
* datetime_field 
* datetime_local_field
* email_field
* month_field 
* number_field
* password_field 
* phone_field
* range_field 
* search_field 
* telephone_field
* text_area 
* text_field
* time_field
* url_field
* week_field

These helpers accecpt the same options as the standard Rails form helpers with a few extra options:

##Form Styles

By default, your forms will stack labels on top of controls and your controls will grow to 100% of the available width.

###Inline Forms

To use inline forms, just use the `layout: :inline` option. You can also hide the labels by setting the `hide_label:` to true.

```erb
<%= form_for @user, layout: :inline do |f| %>
	<%= f.email_field :email, placeholder: 'Email', hide_label: true %>
	<%= f.password_field :password, placeholder: 'Password', hide_label: true %>
	<%= f.primary %>
<% end%>
```

Which outputs:

```html
<form class="new_user form-inline" id="new_user" action="/users" method="post">
	<div class="form-group">
		<label class="form-control-label sr-only" for="user_email">Email</label>
		<input placeholder="Email" class="form-control" type="email" name="user[email]" id="user_email" />
	</div>
	<div class="form-group">
		<label class="form-control-label sr-only" for="user_password">Password</label>
		<input placeholder="Password" class="form-control" type="password" name="user[password]" id="user_password" />
	</div>
	<input type="submit" name="commit" value="Create User" class="btn btn-default btn btn-primary" />
</form>
```

### Using the Grid

You can use Bootstrap's grid by adding the `label_col` and `control_col` width classes:

```erb
<%= form_for @user, label_col: 'col-sm-2', control_col: 'col-sm-8' do |f| %>
	<%= f.text_field :name %>
	<%= f.email_field :email %>
	<%= f.password_field :password %>
	<%= f.password_field :password_confirmation %>
	<%= f.primary %>
<% end%>
```

Which outputs:

```html
<form class="new_user" id="new_user" action="/users" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" />
	<div class="form-group row">
		<label class="form-control-label col-sm-2" for="user_name">Name</label>
		<div class="col-sm-8">
			<input class="form-control" type="text" name="user[name]" id="user_name" />
		</div>
	</div>
	<div class="form-group row">
		<label class="form-control-label col-sm-2" for="user_email">Email</label>
		<div class="col-sm-8">
			<input class="form-control" type="email" name="user[email]" id="user_email" />
		</div>
	</div>
	<div class="form-group row">
		<label class="form-control-label col-sm-2" for="user_password">Password</label>
		<div class="col-sm-8">
			<input class="form-control" type="password" name="user[password]" id="user_password" />
		</div>
	</div>
	<div class="form-group row">
		<label class="form-control-label col-sm-2" for="user_password_confirmation">Password confirmation</label>
		<div class="col-sm-8">
			<input class="form-control" type="password" name="user[password_confirmation]" id="user_password_confirmation" />
		</div>
	</div>
	<input type="submit" name="commit" value="Create User" class="btn btn-default btn btn-primary" />
</form>
```

If you are going to use inline errors, and want them to appear to the right of the input controls, you will need to reserve a few columns on the right of the fields. If not, the errors will appear below the input controls. You can always add a class to the inline-errors to position them where you want to. (See Errors Section below.)


## Labels

Use the `label` option if you want to specify the field's label text:

```erb
<%= f.password_field :password_confirmation, label: "Confirm Password" %>
``` 

To hide a label, use `hide_label: true` option, which addes the `sr-only` class to your labels. This keeps yous labels accessible to those using screen readers.

```erb
<%= f.text_field :email, placeholder: "Email", hide_label: true %>
```

To add custom classes to the field's label:

```erb
<%= f.text_field :email, placeholder: "Email", label_class: "custom-class" %>
```

## Container Attributes

If you want to add an additional css class to the containing div, you can use the `:container_class` option.

```erb
<%= f.text_field :name, container_class: 'extra-class' %>
``` 

Which produces the following output:

```html
<div class="form-group extra-class">
	<label class="form-control-label" for="user_name">Name</label>
	<input class="form-control" type="text" name="user[name]" id="user_name" />
</div>
```

## Checkboxes and Radio Buttons

Checkboxes and radio buttons need to be placed inside of a form_group to display properly. 



```erb
<%= f.form_group :gender do %>
	<%= f.radio_button :gender, "male" %>
	<%= f.radio_button :gender, "female" %>
<% end %>
```

```erb
<%= f.form_group :accept do %>
	<%= f.checkbox :accept, label: "I agree to the Terms."%>
<% end %>
```

You can also create a checkbox using a block:

```erb
<%= f.form_group :accept do %>
	<%= f.checkbox :accept do %>
		You need to agree to our Terms.
	<% end %>
<% end %>
```

You can also have radio buttons and checkboxes arranged inline:

```erb
<%= f.form_group :gender do %>
	<%= f.radio_button :gender, "male", inline: true %>
	<%= f.radio_button :gender, "female", inline: true %>
<% end %>
```

```erb
<%= f.form_group :category do %>
	<%= f.checkbox :category_1, label: "Cat 1", inline: true %>
	<%= f.checkbox :category_2, label: "Cat 2", inline: true %>
<% end %>
```

You can include a label and label class to the form group:

```erb
<%= f.form_group :gender, label: "Gender", label_class: "gender-class" do %>
	<%= f.radio_button :gender, "male" %>
	<%= f.radio_button :gender, "female" %>
<% end %>
```

## Submit Buttons

The `btn btn-default` css classes are automatically added to your submit
buttons.

```erb
<%= f.submit %>
```

You can also use the `primary` helper, which adds `btn btn-primary` to your
submit button:

```erb
<%= f.primary "Optional Label" %>
```

You can specify your own classes like this:

```erb
<%= f.submit "Log In", class: "btn btn-success" %>
```


##Validations & Errors

By default, rails wraps fields that have validation errors in a div (field_with_errors), but this form builder suppresses this behavior. This keeps the html consistent for all fields. Instead, this form builder adds an `.label-error` class to the invalid field's label, and puts the error message inline with Bootstrap's `.text-muted` class. So you can add your own styles to the inline errors, the `.error-text` class is added to the inline error, also a `.field-with-errors` class is added to the field group, as follows:

```html
<div class="form-group field-with-errors">
	<label class="form-control-label error" for="user_email">Email</label>
	<input placeholder="Email" class="form-control" type="email" value="fred" name="user[email]" id="user_email" />
	<small class="text-muted error-text">invalid email.</small>
</div>
```

Turn off inline errors for the full form by setting the `inline_errors` option to false:

```erb
<%= form_for @user, builder: BootstrapFormBuilder, inline_errors: false do |f| %>

<% end%>
```

###Inline Errors when using the grid

If you still want inline errors when using the grid to create a horizontal form, you have two options. 

1. You can have the errors display to the right of the input controls by adding the appropriate column width class to the inline error:

```erb
<%= form_for @user, label_col: 'col-sm-2', control_col: 'col-sm-7', inline_error_class: 'col-sm-3' do |f| %>
 ...
<% end%>
```

2. You can have the errors display below the input controls by having the labels and input controls take up the full grid, and then add an offset to the inline error:

```erb
<%= form_for @user, label_col: 'col-sm-2', control_col: 'col-sm-10', inline_error_class: 'col-sm-offset-2' do |f| %>
 ...
<% end%>
```

###Alert Messages

To display an error message, you can use the `alert_message` helper. This won't output anything unless a model validation has failed.

```erb
<%= f.alert_message "Please fix the errors below." %>
```
Which outputs:

```html
<div class="alert alert-danger">
	<p>Please fix the errors below.</p>
</div>
```

By default, errors will be displayed inline so this will not display any error summary. To display an error_summary use the `error_summary` option.

```erb
<%= f.alert_message "Please fix the errors below.", error_summary: true %>
```

Which outputs: 

```html
<div class="alert alert-danger">
	<p>Please fix the errors below.</p>
	<ul class="bootstrap-form-error-summary">
		<li>Password can&#39;t be blank</li>
		<li>Email must have an @</li>
	</ul>
</div>
```

You can also output the error summary in an unordered list by using the `error_summary` helper.

```erb
<%= f.error_summary %>
```

```html
<ul class="bootstrap-form-error-summary">
	<li>Password can&#39;t be blank</li>
	<li>Email must have an @</li>
</ul>
```