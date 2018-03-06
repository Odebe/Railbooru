describe "the signin process", :type => :feature do
  let(:user) { FactoryBot.create(:user, password: "password") }

  xit "creates a user" do

  end

  xit "signs me in" do
    visit root_path
    click_link "Войти"

    fill_in "user[username]", with: user.username
    fill_in "user[password]", with: user.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
  end
end