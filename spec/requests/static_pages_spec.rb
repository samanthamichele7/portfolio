require 'spec_helper'

describe "StaticPages" do

  subject { page }

  describe "Home page" do
  	
  	before { visit root_path }

  	it { should have_content('Samantha Geitz') }
  	it { should have_title(full_title('Home')) }

  end

end
