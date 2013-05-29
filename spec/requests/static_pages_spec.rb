require 'spec_helper'

describe "Static pages" do

	#let (:base_title) { "Ruby on Rails Tutorial Sample App" }

	subject { page }

	shared_examples_for "all static pages" do
		it { should have_selector('h1', text: heading) }
		it { should have_selector('title', text: full_title(page_title)) }
	end

	describe "Home page" do
		before{ visit root_path }

		let(:heading) {'Sample App'}
		let(:page_title) {''}

		it_should_behave_like "all static pages"
		it { should_not have_selector('title', text: '| Home') }
		# it { should have_selector('h1', text: 'Sample App') }
		# it { should have_selector('title', text: full_title('')) }
		# it { should_not have_selector('title', text: '| Home') }

		describe "for signed-in users " do
			let(:user) { FactoryGirl.create(:user) }
			before do
				FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
				FactoryGirl.create(:micropost, user: user, content: "Dolor site amet")
				sign_in user
				visit root_path
			end

			it "should render the user's feed" do
				user.feed.each do |item|
					page.should have_selector("li##{item.id}", text: item.content)
				end
			end

			describe "follower/following counts" do
				let(:other_user) { FactoryGirl.create(:user) }
				before do
					other_user.follow!(user)
					visit root_path
				end

				it { should have_link("0 following", href: following_user_path(user)) }
				it { should have_link("1 followers", href: followers_user_path(user)) }
			end

			# describe "pagination" do

			# 	before(:all) { 30.times { FactoryGirl.create(:micropost, user: user) }  }
			# 	after(:all) { user.microposts.delete_all }

			# 	it { should have_selector('div.pagination') }

			# 	it "should list each micropost" do
			# 		user.microposts.paginate(page: 1).each do |micropost|
			# 			page.should have_selector('li', text: micropost.content)
			# 		end
			# 	end
			# end

			it "should not have delete links for microposts not created by current user" do
				user.feed.each do |item|
					if item.user == user
						page.should have_selector("a", text: "delete")
					end
				end
			end
			# describe "as signed in user" do
			# 	before { visit root_url }
			# 	it "should not appear for microposts not created by current user" do
			# 		expect { }
			# 	end
			# end
		end
	end

	describe "Help page" do
		before{ visit help_path }

		# it { should have_selector('h1', text: 'Help')}
		# it { should have_selector('title', text: full_title('Help')) }
		let(:heading) {"Help"}
		let(:page_title) {"Help"}
		it_should_behave_like("all static pages")
	end

	describe "About page" do
		before { visit about_path }

		# it { should have_selector('h1', text:'About Us') }
		# it { should have_selector('title', text: full_title('About')) }
		let(:heading) {"About Us"}
		let(:page_title) {"About"}
		it_should_behave_like("all static pages")
	end

	describe "Contact page" do
		before { visit contact_path }

		# it { should have_selector('h1', text:'Contact') }
		# it { should have_selector('title', text: full_title('Contact')) }
		let(:heading) {"Contact"}
		let(:page_title) {"Contact"}
		it_should_behave_like("all static pages")
	end

	it "should have the right links on the layout" do
		visit root_path
		click_link "About"
		page.should have_selector 'title', text: full_title('About Us')
		click_link "Help"
		page.should have_selector 'title', text: full_title('Help')
		click_link "Contact"
		page.should have_selector 'title', text: full_title('Contact')
		click_link "Home"
		click_link "Sign up now!"
		page.should have_selector 'title', text: full_title('Sign up')
		click_link "sample app"
		page.should have_selector 'title', text: full_title('')
	end
end
