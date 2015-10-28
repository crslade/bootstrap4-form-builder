require 'test_helper'

class Bootstrap4FormBuilderRadioCheckTest < ActionView::TestCase
  
  def setup
    @builder = Bootstrap4FormBuilder::FormBuilder::BootstrapBuilder.new(:user, nil, self, {})
  end
  
  test "radio_button is wrapped correctly" do
    expected = %{<div class="form-group"><div class="radio"><label class="" for="user_male_male"><input type="radio" value="male" name="user[gender]" id="user_gender_male" /> Male</label></div><div class="radio"><label class="" for="user_female_female"><input type="radio" value="female" name="user[gender]" id="user_gender_female" /> Female</label></div></div>}
    output = @builder.form_group(:gender) do
      @builder.radio_button(:gender, "male") + @builder.radio_button(:gender, "female")
    end 
    
    assert_equal expected, output
  end
  
  test "check_box is wrapped correctly" do
    expected = %{<div class="form-group"><div class="checkbox"><label for="user_agree"><input name="user[agree]" type="hidden" value="0" /><input type="checkbox" value="1" name="user[agree]" id="user_agree" /> Agree to Terms</label></div></div>}
    output = @builder.form_group(:agree) do
      @builder.check_box :agree, label: "Agree to Terms"
    end 
    
    assert_equal expected, output
  end
  
  test "radio_button inline is wrapped correctly" do
    expected = %{<div class="form-group"><label class="radio-inline " for="user_male_male"><input type="radio" value="male" name="user[gender]" id="user_gender_male" /> Male</label><label class="radio-inline " for="user_female_female"><input type="radio" value="female" name="user[gender]" id="user_gender_female" /> Female</label></div>}
    output = @builder.form_group(:gender) do
      @builder.radio_button(:gender, "male", inline: true)+@builder.radio_button(:gender, "female", inline: true)
    end 
    
    assert_equal expected, output
  end
  
  test "check_box inline is wrapped correctly" do
    expected = %{<div class="form-group"><label class="checkbox-inline" for="user_agree"><input name="user[agree]" type="hidden" value="0" /><input type="checkbox" value="1" name="user[agree]" id="user_agree" /> Agree to Terms</label></div>}
    output = @builder.form_group(:agree) do
      @builder.check_box :agree, label: "Agree to Terms", inline: true
    end 
    
    assert_equal expected, output
  end
  
  test "form_group label and label_class are included" do
    expected = %{<div class="form-group"><label class="terms-label">Terms</label><div class="checkbox"><label for="user_agree"><input name="user[agree]" type="hidden" value="0" /><input type="checkbox" value="1" name="user[agree]" id="user_agree" /> Agree to Terms</label></div></div>}
    output = @builder.form_group(:agree, label: "Terms", label_class: "terms-label") do
      @builder.check_box :agree, label: "Agree to Terms"
    end 
    
    assert_equal expected, output
  end
end