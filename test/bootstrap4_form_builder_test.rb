require 'test_helper'

class Bootstrap4FormBuilderTest < ActionView::TestCase
  
  def setup
    @builder = Bootstrap4FormBuilder::FormBuilder::BootstrapBuilder.new(:user, nil, self, {})
    @inline_builder = Bootstrap4FormBuilder::FormBuilder::BootstrapBuilder.new(:user, nil, self, {layout: :inline})
    @gridded_builder = Bootstrap4FormBuilder::FormBuilder::BootstrapBuilder.new(:user, nil, self, {label_col: 'col-sm-2', control_col: 'col-sm-8'})
  end
  
  test "color_field is wrapped correctly" do
    expected = %{<div class="form-group"><label class="" for="user_color">Color</label><input class="form-control" value="#000000" type="color" name="user[color]" id="user_color" /></div>}
    assert_equal expected, @builder.color_field(:color)
  end
  
  test "date_field is wrapped correctly" do
    expected = %{<div class="form-group"><label class="" for="user_birthdate">Birthdate</label><input class="form-control" value="#000000" type="color" name="user[birthdate]" id="user_birthdate" /></div>}
    assert_equal expected, @builder.color_field(:birthdate)
  end
  
  test "datetime_local_field is wrapped correctly" do
    expected = %{<div class="form-group"><label class="" for="user_birthdate">Birthdate</label><input class="form-control" type="datetime-local" name="user[birthdate]" id="user_birthdate" /></div>}
    assert_equal expected, @builder.datetime_local_field(:birthdate)
  end
  
  test "email_field is wrapped correctly" do
    expected = %{<div class="form-group"><label class="" for="user_email">Email</label><input class="form-control" type="email" name="user[email]" id="user_email" /></div>}
    assert_equal expected, @builder.email_field(:email)
  end
  
  test "month_field is wrapped correctly" do
    expected = %{<div class="form-group"><label class="" for="user_month">Month</label><input class="form-control" type="month" name="user[month]" id="user_month" /></div>}
    assert_equal expected, @builder.month_field(:month)
  end
  
  test "number_field is wrapped correctly" do
    expected = %{<div class="form-group"><label class="" for="user_number">Number</label><input class="form-control" type="number" name="user[number]" id="user_number" /></div>}
    assert_equal expected, @builder.number_field(:number)
  end
  
  test "password_field is wrapped correctly" do
    expected = %{<div class="form-group"><label class="" for="user_password">Password</label><input class="form-control" type="password" name="user[password]" id="user_password" /></div>}
    assert_equal expected, @builder.password_field(:password)
  end
  
  test "phone_field is wrapped correctly" do
    expected = %{<div class="form-group"><label class="" for="user_phone">Phone</label><input class="form-control" type="tel" name="user[phone]" id="user_phone" /></div>}
    assert_equal expected, @builder.phone_field(:phone)
  end
  
  test "range_field is wrapped correctly" do
    expected = %{<div class="form-group"><label class="" for="user_range">Range</label><input class="form-control" type="range" name="user[range]" id="user_range" /></div>}
    assert_equal expected, @builder.range_field(:range)
  end
  
  test "search_field is wrapped correctly" do
    expected = %{<div class="form-group"><label class="" for="user_search">Search</label><input class="form-control" type="search" name="user[search]" id="user_search" /></div>}
    assert_equal expected, @builder.search_field(:search)
  end
  
  test "telephone_field is wrapped correctly" do
    expected = %{<div class="form-group"><label class="" for="user_phone">Phone</label><input class="form-control" type="tel" name="user[phone]" id="user_phone" /></div>}
    assert_equal expected, @builder.telephone_field(:phone)
  end
  
  test "text_field is wrapped correctly" do
    expected = %{<div class="form-group"><label class="" for="user_name">Name</label><input class="form-control" type="text" name="user[name]" id="user_name" /></div>}
    assert_equal expected, @builder.text_field(:name)
  end
  
  test "text_area is wrapped correctly" do
    expected = %{<div class="form-group"><label class="" for="user_comments">Comments</label><textarea class="form-control" name="user[comments]" id="user_comments">\n</textarea></div>}
    assert_equal expected, @builder.text_area(:comments)
  end
  
  test "time_field is wrapped correctly" do
    expected = %{<div class="form-group"><label class="" for="user_time">Time</label><input class="form-control" type="time" name="user[time]" id="user_time" /></div>}
    assert_equal expected, @builder.time_field(:time)
  end
  
  test "url_field is wrapped correctly" do
    expected = %{<div class="form-group"><label class="" for="user_url">Url</label><input class="form-control" type="url" name="user[url]" id="user_url" /></div>}
    assert_equal expected, @builder.url_field(:url)
  end
  
  test "week_field is wrapped correctly" do
    expected = %{<div class="form-group"><label class="" for="user_week">Week</label><input class="form-control" type="week" name="user[week]" id="user_week" /></div>}
    assert_equal expected, @builder.week_field(:week)
  end
  
  test "inline text_field is wrapped correctly" do
    expected = %{<div class="form-group"><label class="" for="user_name">Name</label><input placeholder="Name" class="form-control" type="text" name="user[name]" id="user_name" /></div>}
    assert_equal expected, @inline_builder.text_field(:name, placeholder: "Name")
  end
  
  test "gridded form field is wrapped correctly" do
    expected = %{<div class="form-group row"><label class="col-sm-2 form-control-label" for="user_name">Name</label><div class="col-sm-8"><input class="form-control" type="text" name="user[name]" id="user_name" /></div></div>}
    assert_equal expected, @gridded_builder.text_field(:name)
  end
  
  test "submit is classed correctly" do
    expected = %{<input type="submit" name="commit" value="Register" class="btn btn-default" />}
    assert_equal expected, @builder.submit("Register")
  end
  
  test "primary is classed correctly" do
    expected = %{<input type="submit" name="commit" value="Register" class="btn btn-primary" />}
    assert_equal expected, @builder.primary("Register")
  end
  
  test "custom label text is included" do
    expected = %{<div class="form-group"><label class="" for="user_name">Full Name</label><input class="form-control" type="text" name="user[name]" id="user_name" /></div>}
    assert_equal expected, @builder.text_field(:name, label: "Full Name")
  end
  
  test "custom label class is included" do
    expected = %{<div class="form-group"><label class="custom-label" for="user_name">Name</label><input class="form-control" type="text" name="user[name]" id="user_name" /></div>}
    assert_equal expected, @builder.text_field(:name, label_class: "custom-label")
  end
  
  test "label is hidden when requested" do
    expected = %{<div class="form-group"><label class="sr-only" for="user_name">Name</label><input class="form-control" type="text" name="user[name]" id="user_name" /></div>}
    assert_equal expected, @builder.text_field(:name, hide_label: true)
  end
  
  test "custom container class is include" do
    expected = %{<div class="form-group custom-class"><label class="" for="user_name">Name</label><input class="form-control" type="text" name="user[name]" id="user_name" /></div>}
    assert_equal expected, @builder.text_field(:name, container_class: "custom-class")
  end
end
