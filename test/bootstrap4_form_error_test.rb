require 'test_helper'

class Bootstrap4FormErrorTest < ActionView::TestCase
  def setup
    @user = User.new(email: "wrong", password: "pass")
    @user.valid?
    @builder = Bootstrap4FormBuilder::FormBuilder::BootstrapBuilder.new(:user, @user, self, {})
    @inline_builder = Bootstrap4FormBuilder::FormBuilder::BootstrapBuilder.new(:user, @user, self, {inline_error_class: 'col-sm-2'})
    @noninline_error_builder = Bootstrap4FormBuilder::FormBuilder::BootstrapBuilder.new(:user, @user, self, {inline_errors: false})
  end
  
  test "text_field with errors is wrapped correctly" do
    expected = %{<div class="form-group field-with-errors"><label class="label-error" for="user_name">Name</label><input class="form-control" type="text" name="user[name]" id="user_name" /><small class="text-muted error-text">can&#39;t be blank</small></div>}
    assert_equal expected, @builder.text_field(:name)
  end
  
  test "text_field with errors includes inline-error-class" do
    expected = %{<div class="form-group field-with-errors"><label class="label-error" for="user_name">Name</label><input class="form-control" type="text" name="user[name]" id="user_name" /><small class="text-muted error-text col-sm-2">can&#39;t be blank</small></div>}
    assert_equal expected, @inline_builder.text_field(:name)
  end
  
  test "email_field with errors is wrapped correctly" do
    expected = %{<div class="form-group field-with-errors"><label class="label-error" for="user_email">Email</label><input class="form-control" type="email" value="wrong" name="user[email]" id="user_email" /><small class="text-muted error-text">must have an @</small></div>}
    assert_equal expected, @builder.email_field(:email)
  end
  
  test "text_field with errors, without inline errors is wrapped correctly" do
    expected = %{<div class="form-group field-with-errors"><label class="label-error" for="user_name">Name</label><input class="form-control" type="text" name="user[name]" id="user_name" /></div>}
    assert_equal expected, @noninline_error_builder.text_field(:name)
  end
  
  test "alert_message produces the correct html" do
    expected = %{<div class="alert alert-danger"><p>Please fix the errors below.</p></div>}
    assert_equal expected, @builder.alert_message("Please fix the errors below.")
  end
  
  test "alert_message with error_summary produces the correct html" do
    expected = %{<div class="alert alert-danger"><p>Please fix the errors below.</p><ul class="bootstrap-form-error-summary"><li>Name can&#39;t be blank</li><li>Email must have an @</li></ul></div>}
    assert_equal expected, @builder.alert_message("Please fix the errors below.", error_summary: true)
  end
  
  test "error_summary produces the correct html" do
    expected = %{<ul class="bootstrap-form-error-summary"><li>Name can&#39;t be blank</li><li>Email must have an @</li></ul>}
    assert_equal expected, @builder.error_summary
  end
  
end