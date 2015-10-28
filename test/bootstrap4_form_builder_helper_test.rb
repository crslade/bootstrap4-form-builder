require 'test_helper'

class Bootstap4FormBuilderHelperTest < ActionView::TestCase
  include Bootstrap4FormBuilder::Helper
    
  test "default forms" do
    expected = %{<form role="form" class="new_user" id="new_user" action="/users" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" /><div class="form-group"><label class="form-control-label" for="user_name">Name</label><input class="form-control" type="text" name="user[name]" id="user_name" /></div></form>}
    assert_equal expected, bootstrap_form_for(User.new) { |f| f.text_field(:name)}
  end
  
  test "inline forms" do
    expected = %{<form role="form" class="new_user form-inline" id="new_user" action="/users" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" /><div class="form-group"><label class="form-control-label" for="user_name">Name</label><input class="form-control" type="text" name="user[name]" id="user_name" /></div></form>}
    assert_equal expected, bootstrap_form_for(User.new, layout: :inline) { |f| f.text_field(:name)}
  end
  
  test "gridded forms" do
    expected = %{<form role="form" class="new_user" id="new_user" action="/users" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" /><div class="form-group row"><label class="form-control-label col-sm-2" for="user_name">Name</label><div class="col-sm-10"><input class="form-control" type="text" name="user[name]" id="user_name" /></div></div></form>}
    assert_equal expected, bootstrap_form_for(User.new, label_col: 'col-sm-2', control_col: 'col-sm-10') { |f| f.text_field(:name)}
  end
end